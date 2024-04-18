<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;
use App\Models\Admin\Ratings;
use App\Models\Admin\Sliders;
use App\Models\Admin\ProductCategories;
use App\Models\Admin\ProductSubCategories;
use App\Models\API\Products;
use App\Models\Admin\Users;
use App\Models\Admin\Brands;
use App\Models\Admin\ContactUs;
use App\Models\Admin\Newsletter;

class HomeController extends BaseController
{
    public function index(Request $request)
    {
        $token = $request->query('token');
        if ($token) {
            $user = Users::where('token', $token)->first();
            if ($user && is_null($user->verified_at)) {
                $user->verified_at = now(); 
                $user->save();
            }
        }
        $sliders = Sliders::where('status',1)->get();
        $testimonials = Ratings::where('status',1)->get();
        return view('frontend.home.index', ['sliders' => $sliders,'testimonials' => $testimonials]);
    }

    public function listing(Request $request, $category, $subCategory = null)
    {
        $product = Products::select(['id'])->where('slug', 'LIKE', $category)->where('status', 1)->limit(1)->first();
        if($product)
        {
            $product = Products::where('slug', 'LIKE', $category)->where('status', 1)->limit(1)->first();
            $similarProducts = Products::where('id', '!=', $product->id)->where('category_id', $product->category_id)->where('status', 1)->orderByRaw('rand()')->limit(4)->get();
            return view('frontend.products.detail', [
                'product' => $product,
                'similarProducts' => $similarProducts
            ]);
        }
        else
        {
            $category = ProductCategories::select(['id','title', 'slug', 'description', 'image'])->where('slug', 'LIKE', $category)->where('status', 1)->limit(1)->first();
            if(!$category) { abort(404); }

            if($subCategory){
                $subCategory = ProductSubCategories::select(['title', 'slug', 'description', 'image'])->where('category_id', $category->id)->where('status', 1)->where('slug', 'LIKE', $subCategory)->limit(1)->first();
                if(!$subCategory) {abort('404'); }
            }
            
            $categories = ProductSubCategories::select(['title', 'slug', 'description', 'image'])->where('category_id', $category->id)->where('status', 1)->get();
            $brands = Brands::select(['id', 'title', 'slug'])->where('status', 1)->orderBy('title', 'asc')->get();
            return view('frontend.products.index', [
                'category' => $category,
                'subCategory' => $subCategory,
                'brands' => $brands,
                'categories' => $categories
            ]);
        }
    }

    public function newsletter(Request $request)
    {
        if($request->get('email'))
        {
            $exist = Newsletter::where('email', 'LIKE', $request->get('email'))->limit(1)->first();
            if($exist)
            {
                return Response()->json([
                    'status' => false,
                    'message' => 'You have already subscribed our newsletter.'
                ]);
            }
            else
            {
                $newsletter = new Newsletter();
                $newsletter->email = $request->get('email');
                $newsletter->created = date('Y-m-d H:i');
                $newsletter->modified = date('Y-m-d H:i');
                $newsletter->save();
                return Response()->json([
                    'status' => true,
                    'message' => 'Thank you for subscribing our newsletter. '
                ]);
            }
            
        }
        else
        {
            return Response()->json([
                'status' => false,
                'message' => 'Please enter a valid email address.'
            ]);
        }
    }

    function search(Request $request)
    {
        return redirect('/' . $request->get('category') . '?search=' . $request->get('search'));
    }

    function contactUs(Request $request)
    {
    	if($request->isMethod('post'))
    	{
    		$data = $request->toArray();
    		unset($data['_token']);
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'firstname' => ['required'],
	                'lastname' => 'required',
					'number' => ['required'],
					'email' => ['required'],
					'message' => ['required'],
	            ]
	        );
	        if(!$validator->fails())
	        {
	        	$page = ContactUs::create($data);
	        	if($page)
	        	{
	        		// $request->session()->flash('success', 'Brand created successfully.');
	        		return redirect()->route('admin.brands');
	        	}
	        	else
	        	{
	        		// $request->session()->flash('error', 'Brand could not be save. Please try again.');
		    		// return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}

	    return view("admin/brands/add", [
	    		]);
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;
use App\Libraries\General;
use App\Libraries\Paypal;
use App\Models\Admin\Ratings;
use App\Models\Admin\Sliders;
use App\Models\Admin\ProductSubCategories;
use App\Models\Admin\Users;
use App\Models\Admin\Brands;
use App\Models\Admin\ContactUs;
use App\Models\Admin\Newsletter;
use App\Models\Admin\ProductSizeRelation;
use App\Models\Admin\Settings;
use App\Models\API\Products;
use App\Models\API\ProductCategories;
use App\Models\Admin\OrderProductRelation;
use App\Models\Admin\Orders;
use Illuminate\Support\Facades\Validator;

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
			if(!$product) {
				abort('404');
			}
            $product->sizes = ProductSizeRelation::select(['product_sizes.*', 'products.title as title', 'products.slug', 'products.image', 'colours.title as color'])
            ->leftJoin('products', 'products.id', '=', 'product_sizes.product_id')
            ->leftJoin('colours', 'colours.id', '=', 'product_sizes.color_id')
            ->where('product_id', $product->id)->get();
            $similarProducts = Products::where('id', '!=', $product->id)->where('category_id', $product->category_id)->where('status', 1)->orderByRaw('rand()')->limit(4)->get();
            return view('frontend.products.detail', [
                'product' => $product,
                'similarProducts' => $similarProducts,
                'logoOptions' => [
                    'category' => json_decode(Settings::get('logo_options')),
                    'positions' => json_decode(Settings::get('logo_positions')),
                ]
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
                    $userData = [
                        '{first_name}' => $data['firstname'],
                        '{last_name}' => $data['lastname'],
                        '{email}' => $data['email'],
                    ];
                    General::sendTemplateEmail($data['email'], 'thank-you-for-contacting', $userData);
                    $adminData = [
                        '{first_name}' => $data['firstname'],
                        '{last_name}' => $data['lastname'],
                        '{email}' => $data['email'],
                        '{number}' => $data['number'],
                        '{message}' => $data['message'],
                    ];
                    $adminEmail = Settings::get('admin_notification_email');
                    if($adminEmail)
                    {
                        General::sendTemplateEmail($adminEmail, 'admin-contact-us-request-received', $adminData);
                    }
	        		$request->session()->flash('success', 'Contact Us request send successfully.');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Contact Us request could not be send. Please try again.');
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}
    }
    
    function createBooking(Request $request)
	{
		$data = $request->toArray();
		$validator = Validator::make(
			$data,
			[
                'first_name' => ['required'],
				'last_name' => ['required'],
				'address' => ['required'],
				'postalcode' => ['required'],				
				'cart' => ['required'],
                'cart' => ['required', 'array'],
                'cart.*.quantity' => ['required', 'integer', 'min:1'],
			]
		);
		if(!$validator->fails())
		{
			$user = $request->session()->get('user');
			$order = new Orders();
			$order->customer_id = $user ? $user->id : null;
			$order->first_name = $request->get('first_name');
			$order->last_name = $request->get('last_name');
			$order->customer_id = null;
			$order->company = $request->get('company');
			if($user)
			{
				$order->customer_email = $user->email;
				$order->customer_phone = $user->phonenumber;
			}
			else
			{

				$order->customer_email = $request->get('phone_email') && filter_var($request->get('phone_email'), FILTER_VALIDATE_EMAIL) !== false ? $request->get('phone_email') : null;
				$order->customer_phone = $request->get('phone_email') && filter_var($request->get('phone_email'), FILTER_VALIDATE_EMAIL) !== false ? null : $request->get('phone_email');
			}
			$order->manual_address = 1;
			$order->address = $data['address'];
			$order->area = ($data['address2'] ? $data['address2'] : null);
			$order->city = $data['city'];
			$order->postcode = $data['postalcode'];
			$order->coupon = isset($data['coupon']) && $data['coupon'] ? json_encode($data['coupon']) : null;
			$order->status = 'pending';
			$order->created = date('Y-m-d H:i:s');
			if($request->get('lastId'))
			{
				Orders::whereNull('status')->where('perfix_id', $data['lastId'])->where('paid', 0)->whereDay('created', now()->day)->delete();
			}

			if($order->save()) 
			{
				$order->prefix_id = Settings::get('order_prefix') + $order->id;
				$order->save();

				$products = [];
				$discount = 0;
				$subtotal = 0;
				$margin = 0;
				$includeTravelCharges = 0;
				foreach($data['cart'] as $c)
				{
					$products[] = [
						'order_id' => $order->id,
						'product_id' => $c['product_id'],
						'size_id' => $c['id'],
						'size_title' => $c['size_title'] . ' ' . $c['from_cm'] . ' - ' . $c['to_cm'],
						'color' => $c['color'],
						'product_title' => $c['title'],
						'product_description' => $c['size_title'] . ' ' . $c['from_cm'] . ' - ' . $c['to_cm']."\nChest:" . (isset($c['chest']) && $c['chest'] ? $c['chest'] : '') ."Waist: ".(isset($c['waist']) && $c['waist'] ? $c['waist'] : '')." Hip:".(isset($c['hip']) && $c['hip'] ? $c['hip'] : ''),
						'amount' => $c['price'],
						'quantity' => $c['quantity']
					];
					$subtotal += $c['quantity'] * $c['price'];
				}

				if($products)
				{
					OrderProductRelation::insert($products);
					
					$link = url('/admin/order/'.$order->id.'/view');
					$order->subtotal = $subtotal;
					$order->tax_percentage = Settings::get('gst');

					if(isset($data['coupon']) && $data['coupon'] && $data['coupon']['is_percentage'] > 0 && $data['coupon']['amount'] > 0) {
						$discount = ($subtotal * $data['coupon']['amount'])/100;
					}
					elseif(isset($data['coupon']) && $data['coupon'] && $data['coupon']['amount'] > 0) {
						$discount = $data['coupon']['amount'] > $subtotal ? $subtotal : $data['coupon']['amount'];
					}
					$order->discount = $discount;
					$order->tax_percentage = Settings::get('gst');
					$order->tax = (($subtotal - $discount) * $order->tax_percentage) / 100;
					$order->total_amount = ($subtotal - $discount) + $order->tax;
					$order->save();
					
				}

				return Response()->json([
					'status' => true,
					'orderId' => $order->prefix_id
				]);
			}
			else
			{
				return Response()->json([
					'status' => true
				]);
			}
		}
		else
		{
            return Response()
                ->json([
                    'status' => false,
                    'clear' => true,
                    'message' => 'Something went wrong. Please try again.'
                ]);
		}
	}
}

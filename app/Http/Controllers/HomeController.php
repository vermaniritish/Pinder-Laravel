<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;
use App\Models\Admin\Ratings;
use App\Models\Admin\Sliders;
use App\Models\Admin\ProductCategories;
use App\Models\Admin\ProductSubCategories;
use App\Models\Admin\Users;
use App\Models\Admin\Brands;

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
        $category = ProductCategories::select(['id','title', 'slug', 'description', 'image'])->where('slug', 'LIKE', $category)->limit(1)->first();
        if($subCategory)
            $subCategory = ProductSubCategories::select(['title', 'slug', 'description', 'image'])->where('category_id', $category->id)->where('slug', 'LIKE', $subCategory)->limit(1)->first();
        
        $categories = ProductSubCategories::select(['title', 'slug', 'description', 'image'])->where('category_id', $category->id)->get();
        $brands = Brands::select(['id', 'title', 'slug'])->where('status', 1)->orderBy('title', 'asc')->get();
        return view('frontend.products.index', [
            'category' => $category,
            'subCategory' => $subCategory,
            'brands' => $brands,
            'categories' => $categories
        ]);
    }
}

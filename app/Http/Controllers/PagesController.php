<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;
use App\Models\Admin\Pages;

class PagesController extends BaseController
{
    public function aboutUs(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'about-us')->limit(1)->first();
        return view('frontend.page', ['page' => $page]);
    }

    public function faqs(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'faqs')->limit(1)->first();
        return view('frontend.page', ['page' => $page]);
    }

    public function contactUs(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'contact-us')->limit(1)->first();
        return view('frontend.contactUs', ['page' => $page]);
    }
    
    public function termsConditions(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'terms-conditions')->limit(1)->first();
        return view('frontend.page', ['page' => $page]);
    }

    public function privacyPolicy(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'privacy-policy')->limit(1)->first();
        return view('frontend.page', ['page' => $page]);
    }

    public function deliveryInformation(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'delivery-information')->limit(1)->first();
        return view('frontend.page', ['page' => $page]);
    }

    public function returnPolicy(Request $request)
    {
        $page = Pages::where('slug', 'LIKE', 'return-policy')->limit(1)->first();
        return view('frontend.page', ['page' => $page]);
    }

    public function cart(Request $request) 
    {
        return view('frontend.cart', ['page' => null]);
    }

    public function checkout(Request $request) 
    {
        return view('frontend.checkout.index', [
            'page' => null
        ]);
    }
}
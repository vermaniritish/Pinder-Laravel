<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;
use App\Models\Admin\Orders;
use App\Models\Admin\Pages;
use App\Models\Admin\Users;
use Illuminate\Support\Facades\Validator;

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
        $user = $request->session()->get('user');
        return view('frontend.checkout.index', [
            'page' => null,
            'user' => $user
        ]);
    }

    public function myAccount(Request $request) 
    {
        $user = Users::find($request->session()->get('user')->id);
        return view('frontend.account.index', [
            'user' => $user
        ]);
    }

    public function myOrders(Request $request) 
    {
        $user = Users::find($request->session()->get('user')->id);
        $orders = Orders::where('customer_id', $user->id)->select(['prefix_id', 'created', 'status', 'total_amount'])->orderBy('id', 'desc')->limit(500)->get();
        return view('frontend.account.orders', [
            'user' => $user,
            'orders' => $orders
        ]);
    }

    public function editAccount(Request $request) 
    {
        $user = Users::find($request->session()->get('user')->id);
        
        if($request->isMethod('post'))
        {
            $data = $request->toArray();
            unset($data['_token']);
            $validator = Validator::make(
                $data,
                    [
                        'name' => 'required',
                        'address' => 'required',
                    ]
            );
            if(!$validator->fails())
            {
                $data['first_name'] = $data['name'];
                unset($data['name']);
                if(Users::modify($user->id, $data))
                {
                    $user = Users::find($user->id);
                    $request->session()->put('user', $user);
                    $request->session()->flash( 'success', "Profile saved." );
    		        return redirect()->back();
                }
                else
                {
                    $request->session()->flash( 'error', "Profile could not be saved." );
    		        return redirect()->back();
                }
            }
            else
            {
                $request->session()->flash( 'error', current(current($validator->errors())) );
    		    return redirect()->back();
            }
        }

        return view('frontend.account.edit', [
            'user' => $user
        ]);
    }
    
}
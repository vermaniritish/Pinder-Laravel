<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;
use App\Models\Admin\Ratings;
use App\Models\Admin\Sliders;

class HomeController extends BaseController
{
    public function index(Request $request)
    {
        $sliders = Sliders::where('status',1)->whereNull('deleted_at')->get();
        $testimonials = Ratings::whereNull('deleted_at')->get();

        return view('frontend.home.index', ['sliders' => $sliders,'testimonials' => $testimonials]);
    }
}

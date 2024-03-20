<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller as BaseController;

class HomeController extends BaseController
{
    function index(Request $request)
    {
        return view('frontend.home.index');
    }
}
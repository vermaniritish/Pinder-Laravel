<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
Route::middleware(['guest'])->group(function () {

	//Admin public
	include "Admin/auth.php";

	//Public Routes
	Route::get('/', function () {
	    return view('welcome');
	});
});

Route::prefix('admin')->middleware(['adminAuth'])->group(function () {	
	include "Admin/dashboard.php";
	include "Admin/searchSugessions.php";
	include "Admin/admins.php";
	include "Admin/users.php";
	include "Admin/shops.php";
	include "Admin/products.php";
	include "Admin/pages.php";
	include "Admin/profile.php";
	include "Admin/blogs.php";
	include "Admin/emailTemplates.php";
	include "Admin/actions.php";
	include "Admin/activities.php";
	include "Admin/settings.php";
	include "Admin/brand.php";
	include "Admin/coupon.php";
	include "Admin/orders.php";
	include "Admin/staff.php";
});

//Frontend Routes
// Route::middleware(['frontendauth'])->group(function () {
	
// 	Auth Routes
// 	include "Frontend/auth.php";

// });

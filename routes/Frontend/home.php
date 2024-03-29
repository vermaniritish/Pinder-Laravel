<?php
Route::get('/', '\App\Http\Controllers\HomeController@index')
    ->name('home');

Route::get('/about-us', '\App\Http\Controllers\PagesController@index')
    ->name('aboutUs');

Route::get('/faqs', '\App\Http\Controllers\PagesController@faqs')
    ->name('faqs');

Route::get('/contact-us', '\App\Http\Controllers\PagesController@contactUs')
    ->name('contactUs');

Route::get('/privacy-policy', '\App\Http\Controllers\PagesController@privacyPolicy')
    ->name('privacyPolicy');

Route::get('/delivery-information', '\App\Http\Controllers\PagesController@deliveryInformation')
    ->name('deliveryInformation');

Route::get('/return-policy', '\App\Http\Controllers\PagesController@returnPolicy')
    ->name('returnPolicy');

Route::get('/{category}', '\App\Http\Controllers\HomeController@listing')
    ->name('home.listing');

Route::get('/{category}/{subCategory}', '\App\Http\Controllers\HomeController@listing')
    ->name('home.listing');

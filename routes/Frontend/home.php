<?php
Route::get('/', '\App\Http\Controllers\HomeController@index')
    ->name('home');

Route::get('/login', '\App\Http\Controllers\Auth\AuthController@register')->name('login');

Route::get('/about-us', '\App\Http\Controllers\PagesController@aboutUs')
    ->name('aboutUs');

Route::get('/faqs', '\App\Http\Controllers\PagesController@faqs')
    ->name('faqs');

Route::get('/contact-us', '\App\Http\Controllers\PagesController@contactUs')
    ->name('contactUs');

Route::get('/privacy-policy', '\App\Http\Controllers\PagesController@privacyPolicy')
    ->name('privacyPolicy');

Route::get('/terms-conditions', '\App\Http\Controllers\PagesController@termsConditions')
    ->name('termsConditions');

Route::get('/delivery-information', '\App\Http\Controllers\PagesController@deliveryInformation')
    ->name('deliveryInformation');

Route::get('/return-policy', '\App\Http\Controllers\PagesController@returnPolicy')
    ->name('returnPolicy');



Route::post('/newsletter-subscribe', '\App\Http\Controllers\HomeController@newsletter')
    ->name('home.newsletter');

Route::post('/contact-us', '\App\Http\Controllers\HomeController@contactUs')
    ->name('home.contactUs');

Route::get('/search', '\App\Http\Controllers\HomeController@search')
    ->name('home.search');

Route::get('/{category}', '\App\Http\Controllers\HomeController@listing')
    ->name('home.listing');

Route::get('/{category}/{subCategory}', '\App\Http\Controllers\HomeController@listing')
    ->name('home.listing');
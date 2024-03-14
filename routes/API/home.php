<?php
Route::get('/home/information', '\App\Http\Controllers\API\HomeController@information')
    ->name('api.home.information');


Route::get('/home/sugessions', '\App\Http\Controllers\API\HomeController@sugessions')
    ->name('api.home.sugessions');

Route::get('/home/spotlight', '\App\Http\Controllers\API\HomeController@spotlight')
    ->name('api.home.spotlight');

Route::get('/home/products', '\App\Http\Controllers\API\HomeController@products')
    ->name('api.home.products');

Route::get('/home/address', '\App\Http\Controllers\API\HomeController@address')
    ->name('api.home.address');

Route::get('/products/listing', '\App\Http\Controllers\API\HomeController@productsListing')
    ->name('api.products.listing');

Route::get('/products/detail/{slug}', '\App\Http\Controllers\API\HomeController@productDetails')
    ->name('api.products.details');

Route::get('/products/categories', '\App\Http\Controllers\API\ProductsController@categories')
    ->name('api.products.categories');	

Route::post('/products/report', '\App\Http\Controllers\API\ProductsController@report')
    ->name('api.products.report');

Route::get('/home/footer-links', '\App\Http\Controllers\API\HomeController@footerLinks')
    ->name('api.home.footerLinks');	
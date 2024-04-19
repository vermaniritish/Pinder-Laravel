<?php
Route::get('/products/listing', '\App\Http\Controllers\API\HomeController@productsListing')
    ->name('api.home.productsListing');

Route::post('/orders/booking', '\App\Http\Controllers\API\HomeController@createBooking')
    ->name('api.orders.createBooking');
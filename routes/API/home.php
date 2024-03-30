<?php
Route::get('/products/listing', '\App\Http\Controllers\API\HomeController@productsListing')
    ->name('api.home.productsListing');
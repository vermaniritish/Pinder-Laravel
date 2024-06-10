<?php
use App\Http\Controllers\Admin\LogoPriceController;

Route::get('/logo-price', [LogoPriceController::class, 'index'])
    ->name('admin.logoPrice');

Route::get('/logo-price/fetch', [LogoPriceController::class, 'getLogoPrices'])
    ->name('admin.logoPrice.fetch');

Route::get('/logo-price/add', [LogoPriceController::class, 'add'])
    ->name('admin.logoPrice.add');

Route::post('/logo-price/add', [LogoPriceController::class, 'add'])
    ->name('admin.logoPrice.add');



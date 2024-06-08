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

Route::get('/logo-price/{id}/view', [LogoPriceController::class, 'view'])
    ->name('admin.logoPrice.view');

Route::get('/logo-price/{id}/edit', [LogoPriceController::class, 'edit'])
    ->name('admin.logoPrice.edit');

Route::post('/logo-price/{id}/edit', [LogoPriceController::class, 'edit'])
    ->name('admin.logoPrice.edit');

Route::post('/logo-price/bulkActions/{action}', [LogoPriceController::class, 'bulkActions'])
    ->name('admin.logoPrice.bulkActions');

Route::get('/logo-price/{id}/delete', [LogoPriceController::class, 'delete'])
    ->name('admin.logoPrice.delete');


<?php

use App\Http\Controllers\Admin\BrandsController;

Route::get('/brand', [BrandsController::class, 'index'])
    ->name('admin.brands');

Route::get('/brand/add', [BrandsController::class, 'add'])
    ->name('admin.brands.add');

Route::post('/brand/add', [BrandsController::class, 'add'])
    ->name('admin.brands.add');

Route::get('/brand/{id}/view', [BrandsController::class, 'view'])
    ->name('admin.brands.view');

Route::get('/brand/{id}/edit', [BrandsController::class, 'edit'])
    ->name('admin.brands.edit');

Route::post('/brand/{id}/edit', [BrandsController::class, 'edit'])
    ->name('admin.brands.edit');

Route::post('/brand/bulkActions/{action}', [BrandsController::class, 'bulkActions'])
    ->name('admin.brands.bulkActions');

Route::get('/brand/{id}/delete', [BrandsController::class, 'delete'])
    ->name('admin.brands.delete');
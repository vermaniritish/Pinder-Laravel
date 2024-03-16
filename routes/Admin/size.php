<?php
use App\Http\Controllers\Admin\SizeController;

Route::get('/size', [SizeController::class, 'index'])
    ->name('admin.size');

Route::get('/size/add', [SizeController::class, 'add'])
    ->name('admin.size.add');

Route::post('/size/add', [SizeController::class, 'add'])
    ->name('admin.size.add');

Route::get('/size/{id}/view', [SizeController::class, 'view'])
    ->name('admin.size.view');

Route::get('/size/{id}/edit', [SizeController::class, 'edit'])
    ->name('admin.size.edit');

Route::post('/size/{id}/edit', [SizeController::class, 'edit'])
    ->name('admin.size.edit');

Route::post('/size/bulkActions/{action}', [SizeController::class, 'bulkActions'])
    ->name('admin.size.bulkActions');

Route::get('/size/{id}/delete', [SizeController::class, 'delete'])
    ->name('admin.size.delete');


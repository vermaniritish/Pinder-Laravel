<?php

use App\Http\Controllers\Admin\ColourController;

Route::get('/size', [ColourController::class, 'index'])
    ->name('admin.size');

Route::get('/size/add', [ColourController::class, 'add'])
    ->name('admin.size.add');

Route::post('/size/add', [ColourController::class, 'add'])
    ->name('admin.size.add');

Route::get('/size/{id}/view', [ColourController::class, 'view'])
    ->name('admin.size.view');

Route::get('/size/{id}/edit', [ColourController::class, 'edit'])
    ->name('admin.size.edit');

Route::post('/size/{id}/edit', [ColourController::class, 'edit'])
    ->name('admin.size.edit');

Route::post('/size/bulkActions/{action}', [ColourController::class, 'bulkActions'])
    ->name('admin.size.bulkActions');

Route::get('/size/{id}/delete', [ColourController::class, 'delete'])
    ->name('admin.size.delete');


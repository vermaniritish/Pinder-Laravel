<?php
use App\Http\Controllers\Admin\SlidersController;

Route::get('/slider', [SlidersController::class, 'index'])
    ->name('admin.sliders');

Route::get('/slider/add', [SlidersController::class, 'add'])
    ->name('admin.sliders.add');

Route::post('/slider/add', [SlidersController::class, 'add'])
    ->name('admin.sliders.add');

Route::get('/slider/{id}/view', [SlidersController::class, 'view'])
    ->name('admin.sliders.view');

Route::get('/slider/{id}/edit', [SlidersController::class, 'edit'])
    ->name('admin.sliders.edit');

Route::post('/slider/{id}/edit', [SlidersController::class, 'edit'])
    ->name('admin.sliders.edit');

Route::post('/slider/bulkActions/{action}', [SlidersController::class, 'bulkActions'])
    ->name('admin.sliders.bulkActions');

Route::get('/slider/{id}/delete', [SlidersController::class, 'delete'])
    ->name('admin.sliders.delete');


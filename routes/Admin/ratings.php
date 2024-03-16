<?php

use App\Http\Controllers\Admin\RatingsController;

Route::get('/rating', [RatingsController::class, 'index'])
    ->name('admin.ratings');

Route::get('/rating/add', [RatingsController::class, 'add'])
    ->name('admin.ratings.add');

Route::post('/rating/add', [RatingsController::class, 'add'])
    ->name('admin.ratings.add');

Route::get('/rating/{id}/view', [RatingsController::class, 'view'])
    ->name('admin.ratings.view');

Route::get('/rating/{id}/edit', [RatingsController::class, 'edit'])
    ->name('admin.ratings.edit');

Route::post('/rating/{id}/edit', [RatingsController::class, 'edit'])
    ->name('admin.ratings.edit');

Route::post('/rating/bulkActions/{action}', [RatingsController::class, 'bulkActions'])
    ->name('admin.ratings.bulkActions');

Route::get('/rating/{id}/delete', [RatingsController::class, 'delete'])
    ->name('admin.ratings.delete');


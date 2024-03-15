<?php

use App\Http\Controllers\Admin\ColourController;

Route::get('/colours', [ColourController::class, 'index'])
    ->name('admin.colours');

Route::get('/colours/add', [ColourController::class, 'add'])
    ->name('admin.colours.add');

Route::post('/colours/add', [ColourController::class, 'add'])
    ->name('admin.colours.add');

Route::get('/colours/{id}/view', [ColourController::class, 'view'])
    ->name('admin.colours.view');

Route::get('/colours/{id}/edit', [ColourController::class, 'edit'])
    ->name('admin.colours.edit');

Route::post('/colours/{id}/edit', [ColourController::class, 'edit'])
    ->name('admin.colours.edit');

Route::post('/colours/bulkActions/{action}', [ColourController::class, 'bulkActions'])
    ->name('admin.colours.bulkActions');

Route::get('/colours/{id}/delete', [ColourController::class, 'delete'])
    ->name('admin.colours.delete');


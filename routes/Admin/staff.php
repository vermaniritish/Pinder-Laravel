<?php

use App\Http\Controllers\Admin\StaffController;

Route::get('/staff', [StaffController::class, 'index'])
    ->name('admin.staff');

Route::get('/staff/add', [StaffController::class, 'add'])
    ->name('admin.staff.add');

Route::post('/staff/add', [StaffController::class, 'add'])
    ->name('admin.staff.add');

Route::get('/staff/{id}/view', [StaffController::class, 'view'])
    ->name('admin.staff.view');

Route::get('/staff/{id}/edit', [StaffController::class, 'edit'])
    ->name('admin.staff.edit');

Route::post('/staff/{id}/edit', [StaffController::class, 'edit'])
    ->name('admin.staff.edit');

Route::post('/staff/bulkActions/{action}', [StaffController::class, 'bulkActions'])
    ->name('admin.staff.bulkActions');

Route::get('/staff/{id}/delete', [StaffController::class, 'delete'])
    ->name('admin.staff.delete');

Route::post('/staff/{id}/add-doc', [StaffController::class,'addDocument'])->name('admin.staff.addDocument');
Route::get('/staff/{staffId}/document-delete/{id}/{index}', [StaffController::class,'deleteDocument'])->name('admin.staff.documentDelete');


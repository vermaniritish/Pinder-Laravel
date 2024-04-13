<?php
use App\Http\Controllers\Admin\ContactUsController;

Route::get('/contact-us', [ContactUsController::class, 'index'])
    ->name('admin.contactUs');

Route::get('/contact-us/{id}/view', [ContactUsController::class, 'view'])
    ->name('admin.contactUs.view');

Route::post('/contact-us/bulkActions/{action}', [ContactUsController::class, 'bulkActions'])
    ->name('admin.contactUs.bulkActions');

Route::get('/contact-us/{id}/delete', [ContactUsController::class, 'delete'])
    ->name('admin.contactUs.delete');


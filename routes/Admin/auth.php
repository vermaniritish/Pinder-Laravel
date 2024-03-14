<?php
Route::get('/admin', '\App\Http\Controllers\Admin\AuthController@login')
    ->name('admin.admin');

Route::get('/admin/login', '\App\Http\Controllers\Admin\AuthController@login')
    ->name('admin.login');

Route::post('/admin/login', '\App\Http\Controllers\Admin\AuthController@login')
    ->name('admin.login');

Route::get('/admin/forgot-password', '\App\Http\Controllers\Admin\AuthController@forgotPassword')
    ->name('admin.forgotPassword');

Route::post('/admin/forgot-password', '\App\Http\Controllers\Admin\AuthController@forgotPassword')
    ->name('admin.forgotPassword');

Route::get('/admin/recover-password/{hash}', '\App\Http\Controllers\Admin\AuthController@recoverPassword')
    ->name('admin.recoverPassword');

Route::post('/admin/recover-password/{hash}', '\App\Http\Controllers\Admin\AuthController@recoverPassword')
    ->name('admin.recoverPassword');

Route::get('/admin/logout', '\App\Http\Controllers\Admin\AuthController@logout')
    ->name('admin.logout');

Route::get('/admin/second-auth/{token}', '\App\Http\Controllers\Admin\AuthController@secondAuth')
    ->name('admin.secondAuth');

Route::post('/admin/second-auth/{token}', '\App\Http\Controllers\Admin\AuthController@secondAuth')
    ->name('admin.secondAuth');
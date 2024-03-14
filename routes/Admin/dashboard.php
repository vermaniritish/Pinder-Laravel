<?php
Route::get('/dashboard', '\App\Http\Controllers\Admin\DashboardController@index')
    ->name('admin.dashboard');

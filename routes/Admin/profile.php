<?php 
Route::get('/profile', '\App\Http\Controllers\Admin\ProfileController@index')
    ->name('admin.profile');

Route::post('/profile', '\App\Http\Controllers\Admin\ProfileController@index')
    ->name('admin.profile');

Route::get('/change-password', '\App\Http\Controllers\Admin\ProfileController@changePassword')
    ->name('admin.changePassword');

Route::post('/change-password', '\App\Http\Controllers\Admin\ProfileController@changePassword')
    ->name('admin.changePassword');

Route::post('/profile/update-picture', '\App\Http\Controllers\Admin\ProfileController@updatePicture')
    ->name('admin.profile.updatePicture');

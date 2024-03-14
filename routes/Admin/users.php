<?php
Route::get('/users', '\App\Http\Controllers\Admin\UsersController@index')
    ->name('admin.users');

Route::get('/users/add', '\App\Http\Controllers\Admin\UsersController@add')
    ->name('admin.users.add');

Route::post('/users/add', '\App\Http\Controllers\Admin\UsersController@add')
    ->name('admin.users.add');

Route::get('/users/{id}/view', '\App\Http\Controllers\Admin\UsersController@view')
    ->name('admin.users.view');

Route::get('/users/{id}/edit', '\App\Http\Controllers\Admin\UsersController@edit')
    ->name('admin.users.edit');

Route::post('/users/{id}/edit', '\App\Http\Controllers\Admin\UsersController@edit')
    ->name('admin.users.edit');

Route::post('/users/bulkActions/{action}', '\App\Http\Controllers\Admin\UsersController@bulkActions')
    ->name('admin.users.bulkActions');

Route::get('/users/{id}/delete', '\App\Http\Controllers\Admin\UsersController@delete')
    ->name('admin.users.delete');

Route::post('/users/update-picture', '\App\Http\Controllers\Admin\UsersController@updatePicture')
    ->name('admin.users.updatePicture');

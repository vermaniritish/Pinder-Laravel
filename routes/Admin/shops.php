<?php
Route::get('/shops', '\App\Http\Controllers\Admin\ShopsController@index')
    ->name('admin.shops');

Route::get('/shops/{id}/view', '\App\Http\Controllers\Admin\ShopsController@view')
    ->name('admin.shops.view');

Route::get('/shops/add', '\App\Http\Controllers\Admin\ShopsController@add')
    ->name('admin.shops.add');

Route::post('/shops/add', '\App\Http\Controllers\Admin\ShopsController@add')
    ->name('admin.shops.add');

Route::get('/shops/{id}/edit', '\App\Http\Controllers\Admin\ShopsController@edit')
    ->name('admin.shops.edit');

Route::post('/shops/{id}/edit', '\App\Http\Controllers\Admin\ShopsController@edit')
    ->name('admin.shops.edit');

Route::post('/shops/bulkActions/{action}', '\App\Http\Controllers\Admin\ShopsController@bulkActions')
    ->name('admin.shops.bulkActions');

Route::get('/shops/{id}/delete', '\App\Http\Controllers\Admin\ShopsController@delete')
    ->name('admin.shops.delete');
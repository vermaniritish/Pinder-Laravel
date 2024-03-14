<?php
Route::get('/pages', '\App\Http\Controllers\Admin\PagesController@index')
    ->name('admin.pages');

Route::get('/pages/add', '\App\Http\Controllers\Admin\PagesController@add')
    ->name('admin.pages.add');

Route::post('/pages/add', '\App\Http\Controllers\Admin\PagesController@add')
    ->name('admin.pages.add');

Route::get('/pages/{id}/view', '\App\Http\Controllers\Admin\PagesController@view')
    ->name('admin.pages.view');

Route::get('/pages/{id}/edit', '\App\Http\Controllers\Admin\PagesController@edit')
    ->name('admin.pages.edit');

Route::post('/pages/{id}/edit', '\App\Http\Controllers\Admin\PagesController@edit')
    ->name('admin.pages.edit');

Route::post('/pages/bulkActions/{action}', '\App\Http\Controllers\Admin\PagesController@bulkActions')
    ->name('admin.pages.bulkActions');

Route::get('/pages/{id}/delete', '\App\Http\Controllers\Admin\PagesController@delete')
    ->name('admin.pages.delete');
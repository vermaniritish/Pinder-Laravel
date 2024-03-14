<?php
Route::get('/search-sugessions', '\App\Http\Controllers\Admin\SearchSugessionsController@index')
    ->name('admin.searchSugessions');

Route::get('/search-sugessions/add', '\App\Http\Controllers\Admin\SearchSugessionsController@add')
    ->name('admin.searchSugessions.add');

Route::post('/search-sugessions/add', '\App\Http\Controllers\Admin\SearchSugessionsController@add')
    ->name('admin.searchSugessions.add');

Route::get('/search-sugessions/{id}/view', '\App\Http\Controllers\Admin\SearchSugessionsController@view')
    ->name('admin.searchSugessions.view');

Route::get('/search-sugessions/{id}/edit', '\App\Http\Controllers\Admin\SearchSugessionsController@edit')
    ->name('admin.searchSugessions.edit');

Route::post('/search-sugessions/{id}/edit', '\App\Http\Controllers\Admin\SearchSugessionsController@edit')
    ->name('admin.searchSugessions.edit');

Route::post('/search-sugessions/bulkActions/{action}', '\App\Http\Controllers\Admin\SearchSugessionsController@bulkActions')
    ->name('admin.searchSugessions.bulkActions');

Route::get('/search-sugessions/{id}/delete', '\App\Http\Controllers\Admin\SearchSugessionsController@delete')
    ->name('admin.searchSugessions.delete');
<?php
Route::get('/blogs', '\App\Http\Controllers\Admin\Blogs\BlogsController@index')
    ->name('admin.blogs');

Route::get('/blogs/add', '\App\Http\Controllers\Admin\Blogs\BlogsController@add')
    ->name('admin.blogs.add');

Route::post('/blogs/add', '\App\Http\Controllers\Admin\Blogs\BlogsController@add')
    ->name('admin.blogs.add');

Route::get('/blogs/{id}/view', '\App\Http\Controllers\Admin\Blogs\BlogsController@view')
    ->name('admin.blogs.view');

Route::get('/blogs/{id}/edit', '\App\Http\Controllers\Admin\Blogs\BlogsController@edit')
    ->name('admin.blogs.edit');

Route::post('/blogs/{id}/edit', '\App\Http\Controllers\Admin\Blogs\BlogsController@edit')
    ->name('admin.blogs.edit');

Route::post('/blogs/bulkActions/{action}', '\App\Http\Controllers\Admin\Blogs\BlogsController@bulkActions')
    ->name('admin.blogs.bulkActions');

Route::get('/blogs/{id}/delete', '\App\Http\Controllers\Admin\Blogs\BlogsController@delete')
    ->name('admin.blogs.delete');


/*** Categories **/
Route::get('/blogs/categories', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@index')
    ->name('admin.blogs.categories');

Route::get('/blogs/categories/add', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@add')
    ->name('admin.blogs.categories.add');

Route::post('/blogs/categories/add', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@add')
    ->name('admin.blogs.categories.add');

Route::get('/blogs/categories/{id}/edit', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@edit')
    ->name('admin.blogs.categories.edit');

Route::post('/blogs/categories/{id}/edit', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@edit')
    ->name('admin.blogs.categories.edit');

Route::post('/blogs/categories/bulkActions/{action}', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@bulkActions')
    ->name('admin.blogs.categories.bulkActions');

Route::get('/blogs/categories/{id}/delete', '\App\Http\Controllers\Admin\Blogs\BlogCategoriesController@delete')
    ->name('admin.blogs.categories.delete');
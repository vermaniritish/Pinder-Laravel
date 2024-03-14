<?php
Route::get('/products', '\App\Http\Controllers\Admin\Products\ProductsController@index')
    ->name('admin.products');

Route::get('/products/add', '\App\Http\Controllers\Admin\Products\ProductsController@add')
    ->name('admin.products.add');

Route::post('/products/add', '\App\Http\Controllers\Admin\Products\ProductsController@add')
    ->name('admin.products.add');

Route::get('/products/{id}/view', '\App\Http\Controllers\Admin\Products\ProductsController@view')
    ->name('admin.products.view');

Route::get('/products/{id}/edit', '\App\Http\Controllers\Admin\Products\ProductsController@edit')
    ->name('admin.products.edit');

Route::post('/products/{id}/edit', '\App\Http\Controllers\Admin\Products\ProductsController@edit')
    ->name('admin.products.edit');

Route::post('/products/bulkActions/{action}', '\App\Http\Controllers\Admin\Products\ProductsController@bulkActions')
    ->name('admin.products.bulkActions');

Route::get('/products/{id}/delete', '\App\Http\Controllers\Admin\Products\ProductsController@delete')
    ->name('admin.products.delete');


/*** Categories **/
Route::get('/products/categories', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@index')
    ->name('admin.products.categories');

Route::get('/products/categories/add', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@add')
    ->name('admin.products.categories.add');

Route::post('/products/categories/add', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@add')
    ->name('admin.products.categories.add');

Route::get('/products/categories/{id}/edit', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@edit')
    ->name('admin.products.categories.edit');

Route::post('/products/categories/{id}/edit', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@edit')
    ->name('admin.products.categories.edit');

Route::post('/products/categories/bulkActions/{action}', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@bulkActions')
    ->name('admin.products.categories.bulkActions');

Route::get('/products/categories/{id}/delete', '\App\Http\Controllers\Admin\Products\ProductCategoriesController@delete')
    ->name('admin.products.categories.delete');

/** Report  **/
Route::get('/products/reports', '\App\Http\Controllers\Admin\Products\ReportsController@index')
    ->name('admin.products.reports');
Route::post('/products/reports/bulkActions/{action}', '\App\Http\Controllers\Admin\Products\ReportsController@bulkActions')
    ->name('admin.products.reports.bulkActions');
Route::get('/products/reports/{id}/delete', '\App\Http\Controllers\Admin\Products\ReportsController@delete')
    ->name('admin.products.reports.delete');
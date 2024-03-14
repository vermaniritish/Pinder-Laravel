<?php
Route::get('/activities/logs', '\App\Http\Controllers\Admin\ActivitiesController@logs')
    ->name('admin.activities.logs');

Route::get('/activities/logs/{id}/view', '\App\Http\Controllers\Admin\ActivitiesController@logView')
    ->name('admin.activities.logView');

Route::get('/activities/emails', '\App\Http\Controllers\Admin\ActivitiesController@emails')
    ->name('admin.activities.emails');

Route::get('/activities/emails/{id}/view', '\App\Http\Controllers\Admin\ActivitiesController@emailView')
    ->name('admin.activities.emailView');

Route::get('/activities/pages', '\App\Http\Controllers\Admin\ActivitiesController@pages')
    ->name('admin.activities.pages');

Route::post('/activities/bulkActions/{action}', '\App\Http\Controllers\Admin\ActivitiesController@bulkActions')
    ->name('admin.activities.bulkActions');
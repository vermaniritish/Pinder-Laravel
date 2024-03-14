<?php
Route::get('/email-templates', '\App\Http\Controllers\Admin\EmailTemplatesController@index')
    ->name('admin.emailTemplates');

Route::get('/email-templates/{id}/edit', '\App\Http\Controllers\Admin\EmailTemplatesController@edit')
    ->name('admin.emailTemplates.edit');

Route::post('/email-templates/{id}/edit', '\App\Http\Controllers\Admin\EmailTemplatesController@edit')
    ->name('admin.emailTemplates.edit');
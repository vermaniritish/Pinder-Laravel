<?php

Route::post('/actions/uploadFile', '\App\Http\Controllers\Admin\ActionsController@uploadFile')
    ->name('actions.uploadFile');
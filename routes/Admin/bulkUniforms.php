<?php

use App\Http\Controllers\Admin\Products\BulkUniformsController;

Route::get('/bulk-uniforms', [BulkUniformsController::class, 'index'])
    ->name('admin.bulkUniforms');

Route::get('/bulk-uniforms/add', [BulkUniformsController::class, 'add'])
    ->name('admin.bulkUniforms.add');

Route::post('/bulk-uniforms/add', [BulkUniformsController::class, 'add'])
    ->name('admin.bulkUniforms.add');

Route::get('/bulk-uniforms/product/{productId}/offers', [BulkUniformsController::class, 'getOffers'])
    ->name('admin.bulkUniforms.product.offers');

Route::get('/bulk-uniforms/{id}/view', [BulkUniformsController::class, 'view'])
    ->name('admin.bulkUniforms.view');

Route::get('/bulk-uniforms/{id}/edit', [BulkUniformsController::class, 'add'])
    ->name('admin.bulkUniforms.edit');

Route::post('/bulk-uniforms/{id}/edit', [BulkUniformsController::class, 'add'])
    ->name('admin.bulkUniforms.edit');

Route::post('/bulk-uniforms/bulkActions/{action}', [BulkUniformsController::class, 'bulkActions'])
    ->name('admin.bulkUniforms.bulkActions');

Route::get('/bulk-uniforms/{id}/delete', [BulkUniformsController::class, 'delete'])
    ->name('admin.bulkUniforms.delete');

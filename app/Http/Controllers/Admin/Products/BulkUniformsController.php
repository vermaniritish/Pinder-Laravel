<?php

namespace App\Http\Controllers\Admin\Products;

class BulkUniformsController extends UniformsController
{
	protected function isBulkUniforms()
	{
		return true;
	}

	protected function routePrefix()
	{
		return 'admin.bulkUniforms';
	}

	protected function moduleTitle()
	{
		return 'Bulk Uniforms';
	}
}

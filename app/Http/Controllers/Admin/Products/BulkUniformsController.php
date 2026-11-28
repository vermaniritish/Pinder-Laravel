<?php

namespace App\Http\Controllers\Admin\Products;

use Illuminate\Http\Request;

class BulkUniformsController extends UniformsController
{
	public function index(Request $request)
	{
		return redirect()->route('admin.uniforms', $request->query());
	}

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

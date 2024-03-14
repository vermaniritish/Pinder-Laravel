<?php

namespace App\Models\API;

use App\Models\Admin\Shops as AdminShops;
use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Libraries\FileSystem;

class Shops extends AdminShops
{
	/**
    * Get resize images
    *
    * @return array
    */
    public function getImageAttribute($value)
    {
        return $value ? FileSystem::getAllSizeImages($value) : null;
    }
}
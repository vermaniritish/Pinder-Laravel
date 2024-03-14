<?php

namespace App\Models\API;

use App\Models\Admin\SearchSugessions as AdminSearchSugessions;
use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Libraries\FileSystem;

class SearchSugessions extends AdminSearchSugessions
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
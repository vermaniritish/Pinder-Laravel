<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;
use Illuminate\Support\Str;
use App\Libraries\General;

class SearchKeywords extends AppModel
{
    protected $table = 'search_keywords';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**** ONLY USE FOR MAIN TALBLES NO NEED TO USE FOR RELATION TABLES OR DROPDOWNS OR SMALL SECTIONS ***/
    use SoftDeletes;
    

    /**
    * To insert
    * @param $where
    * @param $orderBy
    */
    public static function create($data)
    {
    	$sugession = new SearchKeywords();

    	foreach($data as $k => $v)
    	{
    		$sugession->{$k} = $v;
    	}

    	$sugession->created = date('Y-m-d H:i:s');
    	$sugession->modified = date('Y-m-d H:i:s');
	    if($sugession->save())
	    {
	    	return $sugession;
	    }
	    else
	    {
	    	return null;
	    }
    }
}
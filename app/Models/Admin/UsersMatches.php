<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class UsersMatches extends AppModel
{
    protected $table = 'users_matches';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**
    * To insert
    * @param $where
    * @param $orderBy
    */
    public static function create($data)
    {
    	$match = new UsersMatches();

    	foreach($data as $k => $v)
    	{
    		$match->{$k} = $v;
    	}

    	$match->created = date('Y-m-d H:i:s');
    	$match->modified = date('Y-m-d H:i:s');
	    if($match->save())
	    {
            return $match;
	    }
	    else
	    {
	    	return null;
	    }
    }
}
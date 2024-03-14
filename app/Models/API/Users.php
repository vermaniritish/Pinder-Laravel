<?php

namespace App\Models\API;

use App\Models\Admin\Users as AdminUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;

class Users extends AdminUsers
{
	protected $hidden = ['token', 'password'];

	/**
    * Get resize images
    *
    * @return array
    */
    public function getImageAttribute($value)
    {
        return $value ? FileSystem::getAllSizeImages($value) : null;
    }


    public static function getPermissions($userId)
    {
        $permissions = UsersPermissions::where('user_id', $userId)->get();
        $return = [];
        foreach($permissions as $k => $p)
        {
            $return[$p->permission] = $p->status ? true : false;
        }
        return $return;
    }
}
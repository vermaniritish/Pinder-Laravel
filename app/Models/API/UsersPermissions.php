<?php

namespace App\Models\API;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UsersPermissions extends AppModel
{
	protected $table = 'users_permissions';
    protected $primaryKey = 'id';
    public $timestamps = false;
}
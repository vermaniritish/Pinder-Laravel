<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;

class AdminPermissions extends AppModel
{
    protected $table = 'admin_permissions';
    protected $primaryKey = 'id';
    public $timestamps = false;
}
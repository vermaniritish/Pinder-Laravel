<?php

namespace App\Models;

use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class AppModel extends Model
{
	public static $paginationLimit = 10;

    public function __construct()
    {
        parent::__construct();
    }
}

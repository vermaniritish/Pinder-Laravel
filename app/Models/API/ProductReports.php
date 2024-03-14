<?php

namespace App\Models\API;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductReports extends AppModel
{
	protected $table = 'product_reports';
    protected $primaryKey = 'id';
    public $timestamps = false;
}
<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class BrandProducts extends AppModel
{
    protected $table = 'brand_product';
    protected $primaryKey = 'id';
    public $timestamps = false;
}

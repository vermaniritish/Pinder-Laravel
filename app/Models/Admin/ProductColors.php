<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class ProductColors extends AppModel
{
    protected $table = 'product_colors';
    protected $primaryKey = 'id';
    public $timestamps = false;
}

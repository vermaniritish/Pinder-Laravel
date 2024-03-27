<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class ProductSubCategoryRelation extends AppModel
{
    protected $table = 'product_sub_category_relation';
    protected $primaryKey = 'id';
    public $timestamps = false;
}

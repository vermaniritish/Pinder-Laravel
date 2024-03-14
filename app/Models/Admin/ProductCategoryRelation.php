<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class ProductCategoryRelation extends AppModel
{
    protected $table = 'product_category_relation';
    protected $primaryKey = 'id';
    public $timestamps = false;
}

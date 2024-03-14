<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class BlogCategoryRelation extends AppModel
{
    protected $table = 'blog_category_relation';
    protected $primaryKey = 'id';
    public $timestamps = false;
}
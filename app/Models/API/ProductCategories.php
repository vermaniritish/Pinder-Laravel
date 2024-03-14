<?php

namespace App\Models\API;

use App\Models\AppModel;
use App\Models\Scopes\Active;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ProductCategories extends AppModel
{
    use HasFactory;


    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'product_categories';

    /**
     * The attributes that are not assignable.
     *
     * @var bool
     */
    protected $guarded = [];

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = true;

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'id';

    /**
     * Get the indexable data array for the model.
     *
     * @return array
     */
    public function toSearchableArray()
    {
        return [
            'id',
            'title'
        ];
    }

    /**
	 * The "booted" method of the model.
	 *
	 * @return void
	 */
	protected static function booted() {
		static::addGlobalScope(new Active);
	}

    /**
    * ProductCategories -> Product belongsToMany relation
    *
    * @return ProductCategories
    */
    public function products()
    {
        return $this->belongsToMany(Products::class, 'product_category_relation', 'category_id', 'product_id');
    }

    /**
     * Define a one-to-one relationship.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function brands()
    {
        return $this->belongsToMany(Brands::class, 'brand_product', 'product_id', 'brand_id');
    }
}

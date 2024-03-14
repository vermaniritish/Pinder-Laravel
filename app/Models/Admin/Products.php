<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;
use Illuminate\Support\Str;
use App\Libraries\General;
use App\Models\Admin\Brands as AdminBrands;
use App\Models\Brands;

class Products extends AppModel
{
    protected $table = 'products';
    protected $primaryKey = 'id';
    public $timestamps = false;


    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'tags' => 'array',
    ];
    
    /**** ONLY USE FOR MAIN TALBLES NO NEED TO USE FOR RELATION TABLES OR DROPDOWNS OR SMALL SECTIONS ***/
    use SoftDeletes;

    /**
    * Product -> ProductCategories belongsToMany relation
    *
    * @return ProductCategories
    */
    public function categories()
    {
        return $this->belongsToMany(ProductCategories::class, 'product_category_relation', 'product_id', 'category_id');
    }

    /**
    * Product -> Brands belongsToMany relation
    *
    * @return Brands
    */
    public function brands()
    {
        return $this->belongsToMany(AdminBrands::class, 'brand_product', 'product_id', 'brand_id');
    }

    /**
    * Get resize images
    *
    * @return array
    */
    public function getResizeImagesAttribute()
    {
        return $this->image ? FileSystem::getAllSizeImages($this->image) : null;
    }

    /**
    * Products -> Shops belongsTO relation
    * 
    * @return Shops
    */
    public function shop()
    {
        return $this->belongsTo(Shops::class, 'shop_id', 'id');
    }

    /**
    * Products -> Users belongsTO relation
    * 
    * @return Users
    */
    public function users()
    {
        return $this->belongsTo(Users::class, 'user_id', 'id');
    }

    /**
    * Products -> Admins belongsTO relation
    * 
    * @return Admins
    */
    public function owner()
    {
        return $this->belongsTo(Admins::class, 'created_by', 'id');
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getListing(Request $request, $where = [])
    {
    	$orderBy = $request->get('sort') ? $request->get('sort') : 'products.id';
    	$direction = $request->get('direction') ? $request->get('direction') : 'desc';
    	$page = $request->get('page') ? $request->get('page') : 1;
    	$limit = self::$paginationLimit;
    	$offset = ($page - 1) * $limit;
    	
    	$listing = Products::select([
	    		'products.*',
                'shop_owner.id as shop_owner_id',
                DB::raw('concat(shop_owner.first_name, " ", (CASE WHEN shop_owner.last_name is not null THEN shop_owner.last_name ELSE "" END)) as shop_owner_name'),
	    	])
            ->leftJoin('users as shop_owner', 'shop_owner.id', '=', 'products.user_id')
	    	->orderBy($orderBy, $direction);

	    if(!empty($where))
	    {
	    	foreach($where as $query => $values)
	    	{
	    		if(is_array($values))
                    $listing->whereRaw($query, $values);
                elseif(!is_numeric($query))
                    $listing->where($query, $values);
                else
                    $listing->whereRaw($values);
	    	}
	    }

	    // Put offset and limit in case of pagination
	    if($page !== null && $page !== "" && $limit !== null && $limit !== "")
	    {
	    	$listing->offset($offset);
	    	$listing->limit($limit);
	    }
        
	    $listing = $listing->paginate($limit);

	    return $listing;
    }

    /**
    * To get all records
    * @param $where
    * @param $orderBy
    * @param $limit
    */
    public static function getAll($select = [], $where = [], $orderBy = 'products.id desc', $limit = null)
    {
    	$listing = Products::orderByRaw($orderBy);

    	if(!empty($select))
    	{
    		$listing->select($select);
    	}
    	else
    	{
    		$listing->select([
    			'products.*'
    		]);	
    	}

	    if(!empty($where))
	    {
	    	foreach($where as $query => $values)
	    	{
	    		if(is_array($values))
                    $listing->whereRaw($query, $values);
                elseif(!is_numeric($query))
                    $listing->where($query, $values);
                else
                    $listing->whereRaw($values);
	    	}
	    }
	    
	    if($limit !== null && $limit !== "")
	    {
	    	$listing->limit($limit);
	    }

	    $listing = $listing->get();

	    return $listing;
    }

    /**
    * To get single record by id
    * @param $id
    */
    public static function get($id)
    {
    	$record = Products::where('id', $id)
            ->with([
                'categories' => function($query) {
                    $query->select(['product_categories.id', 'product_categories.title']);
                },
                'users' => function($query) {
                    $query->select(['id', 'first_name', 'last_name', 'status']);
                },
                'owner' => function($query) {
                    $query->select(['id', 'first_name', 'last_name', 'status']);
                },
            ])
            ->first();
            
	    return $record;
    }

    /**
    * To get single row by conditions
    * @param $where
    * @param $orderBy
    */
    public static function getRow($where = [], $orderBy = 'products.id desc')
    {
    	$record = Products::orderByRaw($orderBy);

	    foreach($where as $query => $values)
	    {
	    	if(is_array($values))
                $record->whereRaw($query, $values);
            elseif(!is_numeric($query))
                $record->where($query, $values);
            else
                $record->whereRaw($values);
	    }
	    
	    $record = $record->limit(1)->first();

	    return $record;
    }

    /**
    * To insert
    * @param $where
    * @param $orderBy
    */
    public static function create($data)
    {
    	$product = new Products();

    	foreach($data as $k => $v)
    	{
    		$product->{$k} = $v;
    	}

        $product->created_by = AdminAuth::getLoginId();
    	$product->created = date('Y-m-d H:i:s');
    	$product->modified = date('Y-m-d H:i:s');
	    if($product->save())
	    {
            if(isset($data['title']) && $data['title'])
            {
                $product->slug = Str::slug($product->title) . '-' . General::encode($product->id);
                $product->save();
            }

	    	return $product;
	    }
	    else
	    {
	    	return null;
	    }
    }


    /**
    * To update
    * @param $id
    * @param $where
    */
    public static function modify($id, $data)
    {
    	$product = Products::find($id);
    	foreach($data as $k => $v)
    	{
    		$product->{$k} = $v;
    	}

    	$product->modified = date('Y-m-d H:i:s');
	    if($product->save())
	    {
            if(isset($data['title']) && $data['title'])
            {
                $product->slug = Str::slug($product->title) . '-' . General::encode($product->id);
                $product->save();
            }

	    	return $product;
	    }
	    else
	    {
	    	return null;
	    }
    }

    
    /**
    * To update all
    * @param $id
    * @param $where
    */
    public static function modifyAll($ids, $data)
    {
    	if(!empty($ids))
    	{
    		return Products::whereIn('products.id', $ids)
		    		->update($data);
	    }
	    else
	    {
	    	return null;
	    }

    }

    /**
    * To delete
    * @param $id
    */
    public static function remove($id)
    {
    	$product = Products::find($id);
        $images = $product->getResizeImagesAttribute();
    	if($product->delete())
        {
            if($images)
            {
                foreach($images as $img)
                {
                    foreach($img as $i)
                    {
                        if($i && is_dir(public_path($i)) && file_exists(public_path($i)))
                        {
                            unlink(public_path($i));
                        }
                    }
                }
            }
            return true;
        }
        else
        {
            return false;
        }
    }

    /**
    * To delete all
    * @param $id
    * @param $where
    */
    public static function removeAll($ids)
    {
    	if(!empty($ids))
    	{
    		foreach($ids as $id)
            {
                Products::remove($id);
            }

            return true;
	    }
	    else
	    {
	    	return null;
	    }

    }

    public static function handleBrands($id, $brands)
    {
        //Delete all first
        BrandProducts::where('product_id', $id)->delete();
        // Then Save
        foreach($brands as $c)
        {
            $relation = new BrandProducts();
            $relation->product_id = $id;
            $relation->brand_id = $c;
            $relation->created = date('Y-m-d H:i:s');
    	    $relation->modified = date('Y-m-d H:i:s');
            $relation->save();
        }
    }

    public static function handleCategories($id, $categories)
    {
        //Delete all first
        ProductCategoryRelation::where('product_id', $id)->delete();
        // Then Save
        foreach($categories as $c)
        {
            $relation = new ProductCategoryRelation();
            $relation->product_id = $id;
            $relation->category_id = $c;
            $relation->save();
        }

        $product = Products::find($id);
    }
}
<?php

namespace App\Models\API;

use App\Models\Admin\Products as AdminProducts;
use App\Models\Admin\Settings;
use App\Models\Admin\SearchSugessions;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;
use App\Models\Scopes\Active;

class Products extends AdminProducts
{
    protected $table = 'products';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    /**
	 * The "booted" method of the model.
	 *
	 * @return void
	 */
	protected static function booted() {
		static::addGlobalScope(new Active);
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
    /**
    * Get resize images
    *
    * @return array
    */
    public function getImageAttribute($value)
    {
        $value = $value ? FileSystem::getAllSizeImages($value) : null;
        if($value)
        {
            foreach($value as $k => $v)
            {
                foreach($v as $vk => $i)
                {
                    $v[$vk] = $i . '?' . strtotime($this->modified);
                }
                $value[$k] = $v;
            }
        }

        return $value;
    }

    /**
    * Get cropped areas
    *
    * @return array
    */
    public function getCroppedAreaAttribute($value)
    {
        return $value ? json_decode($value) : null;
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
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getListing(Request $request, $where = [])
    {
        $userId = ApiAuth::getLoginId();
    	$orderBy = $request->get('sort') ? $request->get('sort') : 'products.id';
    	$direction = $request->get('direction') ? $request->get('direction') : 'desc';
    	$page = $request->get('page') ? $request->get('page') : 1;
    	$limit = 20;
    	$offset = ($page - 1) * $limit;
    	   
        $select = [
            'products.id',
            'products.title',
            'products.slug',
            'products.price',
            'products.phonenumber',
            'products.image',
            'products.sale_price',
            'users.first_name',
            'users.last_name',
            'users.image as user_image',
            DB::raw('(CASE WHEN products.sale_price is null or products.sale_price = 0 THEN products.price ELSE products.sale_price END) as price_order'),
            DB::raw('(SELECT AVG(TIMESTAMPDIFF(MINUTE, created, read_at)) as response_seconds from messages where to_id = products.user_id and read_at is not null) as respond'),
            'products.modified',
        ];


        if($request->get('latitude') && $request->get('longitude'))
        {
            $select[] = DB::raw("ROUND( SQRT( POW((69.1 * ((products.lat) - '".$request->get('latitude')."')), 2) + POW((53 * ((products.lng) - '".$request->get('longitude')."')), 2)), 1) AS distance");
        }

        if($userId)
        {
            $select[] = 'users_wishlist.id as wishlist_id';
        }   

    	$listing = Products::select($select)
            ->leftJoin('users', 'users.id', '=', 'products.user_id')
            ->join('product_category_relation', 'product_category_relation.product_id', '=', 'products.id')
            ->join('product_categories', 'product_categories.id', '=', 'product_category_relation.category_id')
            ->where('users.status', 1);
        
        if($userId)
        {
            $listing->leftJoin('users_wishlist', function($join) use ($userId) {
                $join->on('users_wishlist.product_id', '=', 'products.id');
                $join->where('users_wishlist.user_id', '=', $userId);
            });
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

        if($request->get('categories'))
        {
            $cats = $request->get('categories') ? $request->get('categories') : [0];
            $listing->whereIn('product_category_relation.category_id', $cats);
        }

        if($request->get('free_item'))
        {
            $listing->where('products.price', '<', 1);   
        }

        if($request->get('title') && strtolower($request->get('title')) != "all products")
        {
            $ignore = SearchSugessions::where('slug', "all-products")->pluck('title')->first();
            if( !$ignore || strtolower(trim($request->get('title'))) != strtolower(trim($ignore)) )
            {
                $title = explode(' ', $request->get('title'));
                $title = array_filter($title);
                $oR = [];

                 $ignore = Settings::get('ignore_keywords');
                $ignore = ($ignore ? explode(',', $ignore) : []);
                $ignore = array_filter($ignore);
                foreach ($title as $key => $value) {

                   if($value && preg_match("/^[a-zA-Z0-9]+$/", trim($value)) && !in_array(ucfirst(trim($value)), $ignore))
                        $oR[] =  'products.title LIKE "%'.$value.'%"';
                }
                $oR[] = 'products.title LIKE "%' . trim($request->get('title')) . '%"';
                $oR[] = 'product_categories.title LIKE "%' . trim($request->get('title')) . '%"';
                
                $listing->whereRaw('(' . implode(' or ', $oR) . ')');
            }
        }

        // if($request->get('address'))
        // {
        //     $listing->whereRaw('(products.address LIKE ? or products.postcode LIKE ?)', [$request->get('address'), $request->get('address')]);
        // }

        if($request->get('latitude') && $request->get('longitude') && $request->get('radius') !== '' && $request->get('radius') !== null)
        {
            $listing->having('distance', '<=', $request->get('radius'));
        }

        switch ($orderBy) {
            case 'nearest':
                if($request->get('latitude') && $request->get('longitude') && $request->get('radius') > 0)
                {
                    $listing->having('distance', '<=', $request->get('radius'));
                    $listing->orderBy('distance', 'asc');
                }
            break;

            case 'higest_price':
                $listing->orderByRaw('(price_order) desc');
            break;

            case 'lowest_price':
                $listing->orderByRaw('(price_order) asc');
            break;

            case 'recent':
                $listing->orderByRaw('products.id desc');
            break;
            
            default:
                $listing->orderBy($orderBy, $direction);
            break;
        }
        

	    // Put offset and limit in case of pagination
	    if($page !== null && $page !== "" && $limit !== null && $limit !== "")
	    {
	    	$listing->offset($offset);
	    	$listing->limit($limit);
	    }

        $listing->groupBy('products.id');
	    $listing = $listing->paginate($limit);

	    return $listing;
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getSimilarListing(Request $request, $where = [], $type = null)
    {
        $userId = ApiAuth::getLoginId();
        $orderBy = $request->get('sort') ? $request->get('sort') : 'products.id';
        $direction = $request->get('direction') ? $request->get('direction') : 'desc';
        $page = $request->get('page') ? $request->get('page') : 1;
        $limit = 20;
        $offset = ($page - 1) * $limit;
           
        $select = [
            'products.id',
            'products.user_id',
            'products.title',
            'products.slug',
            'products.price',
            'products.image',
            'products.sale_price',
            'users.first_name',
            'users.last_name',
            'users.image as user_image',
            DB::raw('(CASE WHEN products.sale_price is null or products.sale_price = 0 THEN products.price ELSE products.sale_price END) as price_order'),
            DB::raw('(SELECT AVG(TIMESTAMPDIFF(MINUTE, created, read_at)) as response_seconds from messages where to_id = products.user_id and read_at is not null) as respond'),
            'products.modified',
        ];


        if($request->get('latitude') && $request->get('longitude'))
        {
            $select[] = DB::raw("ROUND( SQRT( POW((69.1 * ((products.lat) - '".$request->get('latitude')."')), 2) + POW((53 * ((products.lng) - '".$request->get('longitude')."')), 2)), 1) AS distance");
        }

        if($userId)
        {
            $select[] = 'users_wishlist.id as wishlist_id';
        }   

        $listing = Products::select($select)
            ->leftJoin('users', 'users.id', '=', 'products.user_id')
            ->join('product_category_relation', 'product_category_relation.product_id', '=', 'products.id')
            ->join('product_categories', 'product_categories.id', '=', 'product_category_relation.category_id')
            ->where('users.status', 1);
        
        if($userId)
        {
            $listing->leftJoin('users_wishlist', function($join) use ($userId) {
                $join->on('users_wishlist.product_id', '=', 'products.id');
                $join->where('users_wishlist.user_id', '=', $userId);
            });
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

        if(!$type && $request->get('categories'))
        {
            $cats = $request->get('categories') ? $request->get('categories') : [0];
            $listing->whereIn('product_category_relation.category_id', $cats);
        }

        if(!$type && $request->get('title') && strtolower($request->get('title')) != "all products")
        {
            $oR[] = 'products.title LIKE "%' . trim($request->get('title')) . '%"';
            $oR[] = 'product_categories.title LIKE "%' . trim($request->get('title')) . '%"';
            
            $listing->whereRaw('(' . implode(' or ', $oR) . ')');
        }


        if((!$type || $type == 'location_only') && $request->get('latitude') && $request->get('longitude'))
        {
            $listing->orderBy('distance', 'asc');
        }
        

        // Put offset and limit in case of pagination
        if($page !== null && $page !== "" && $limit !== null && $limit !== "")
        {
            $listing->offset($offset);
            $listing->limit($limit);
        }

        $listing->groupBy('products.id');
        $listing = $listing->paginate($limit);

        return $listing;
    }

    /**
    * To get single record by slug
    * @param $id
    */
    public static function getBySlug($slug)
    {
        $userId = ApiAuth::getLoginId();
        $record = Products::select(['products.*', 'users_wishlist.id as wishlist_id'])
            ->where('slug', 'LIKE', $slug)
            ->whereRaw('(status = 1 or products.user_id = '.($userId ? $userId : 0).')')
            ->leftJoin('users_wishlist', function($join) use ($userId) {
                $join->on('users_wishlist.product_id', '=', 'products.id');
                $join->where('users_wishlist.user_id', '=', $userId);
            })
            ->with([
                'categories' => function($query) {
                    $query->select(['product_categories.id', 'product_categories.title']);
                },
                'users' => function($query) {
                    $query->select(['id', 'first_name', 'last_name', 'image', 'status']);
                }
            ])
            ->first();
        if($record->users)
        {
            $record->first_name = $record->users->first_name;
            $record->last_name = $record->users->last_name;
        }
        return $record;
    }
}
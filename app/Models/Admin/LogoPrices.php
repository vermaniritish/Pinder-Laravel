<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class LogoPrices extends AppModel
{
    protected $table = 'logo_prices';
    protected $primaryKey = 'id';
    public $timestamps = false;
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
        if($product->delete())
        {
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
}
    
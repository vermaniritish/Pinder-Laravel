<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductReports extends AppModel
{
	protected $table = 'product_reports';
    protected $primaryKey = 'id';
    public $timestamps = false;


    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getListing(Request $request, $where = [])
    {
    	$orderBy = $request->get('sort') ? $request->get('sort') : 'product_reports.id';
    	$direction = $request->get('direction') ? $request->get('direction') : 'desc';
    	$page = $request->get('page') ? $request->get('page') : 1;
    	$limit = self::$paginationLimit;
    	$offset = ($page - 1) * $limit;
    	
    	$listing = ProductReports::select([
	    		'product_reports.*',
                'products.title as product_title',
                'owner.first_name as owner_first_name',
                'owner.last_name as owner_last_name',
                'products.deleted_at'
	    	])
            ->leftJoin('users as owner', 'owner.id', '=', 'product_reports.user_id')
            ->leftJoin('products', 'products.id', '=', 'product_reports.product_id')
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
    * To delete
    * @param $id
    */
    public static function remove($id)
    {
    	$report = ProductReports::find($id);
    	return $report->delete();
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
    		return ProductReports::whereIn('product_reports.id', $ids)
		    		->delete();
	    }
	    else
	    {
	    	return null;
	    }

    }
}
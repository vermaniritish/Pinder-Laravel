<?php

namespace App\Models\API;

use App\Models\AppModel;
use Illuminate\Http\Request;
use App\Models\API\ApiAuth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;

class Messages extends AppModel
{
    protected $table = 'messages';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**** ONLY USE FOR MAIN TALBLES NO NEED TO USE FOR RELATION TABLES OR DROPDOWNS OR SMALL SECTIONS ***/
    use SoftDeletes;
    /**
    * To insert
    * @param $where
    */
    public static function create($data)
    {
    	$message = new Messages();

    	foreach($data as $k => $v)
    	{
    		$message->{$k} = $v;
    	}

        $url = '~(?:(https?)://([^\s<]+)|(www\.[^\s<]+?\.[^\s<]+))(?<![\.,:])~i'; 
        $message->message = preg_replace($url, '<a href="$0" target="_blank" title="$0">$0</a>', strip_tags($message->message));
    	$message->created = date('Y-m-d H:i:s');
    	$message->modified = date('Y-m-d H:i:s');
	    if($message->save())
	    {
            return $message;
	    }
	    else
	    {
	    	return null;
	    }
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */
    public static function getListing(Request $request, $where = [])
    {
        $userId = ApiAuth::getLoginId();

    	$page = $request->get('page') ? $request->get('page') : 1;
    	$search = $request->get('search') ? $request->get('search') : null;
    	$limit = 20;
    	$offset = ($page - 1) * $limit;
    	
    	$listing = Messages::select([
    			'messages.*',
                DB::raw("(CASE WHEN deleted_for_everyone = 1 or (from_id = {$userId} and delete_for_me = 1) THEN 'Message Deleted.' ELSE messages.message END) as message"),
    			'users.first_name',
    			'users.last_name',
    			'users.image'
	    	])
    		->leftJoin('users', 'users.id', '=', 'messages.from_id')
            ->orderByRaw('`created` DESC');

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

	    if(!empty($search))
	    {
	    	$search = "%" . $search . '%';
	    	$listing->whereRaw('(messages.message LIKE ?)', [$search]);
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

    public static function getUnreadCounts($userId)
    {
        $totalCounts = Messages::select(['id'])
            ->leftJoin('users_matches', function($join) use ($userId) {
                $join->on('users_matches.match_id', '=', 'messages.from_id')
                    ->whereRaw("users_matches.product_id = messages.product_id and users_matches.user_id = {$userId} and users_matches.match_id = messages.from_id")
                    ->limit(1);
            })
            ->where('to_id', $userId)
            ->where('read', 0)
            ->where('users_matches.is_mute' , 0)
            ->count();
        return $totalCounts;
    }

    public static function getBuyerCounts($userId)
    {
        $totalCounts = Messages::select(['id'])
            ->leftJoin('products', 'products.id', '=', 'messages.product_id')
            ->leftJoin('users_matches', function($join) use ($userId) {
                $join->on('users_matches.match_id', '=', 'messages.from_id')
                    ->whereRaw("users_matches.product_id = messages.product_id and users_matches.user_id = {$userId} and users_matches.match_id = messages.from_id")
                    ->limit(1);
            })
            ->where('products.user_id', $userId)
            ->where('to_id', $userId)
            ->where('read', 0)
            ->where('users_matches.is_mute' , 0)
            ->count();
        return $totalCounts;
    }

    public static function getSellerCounts($userId)
    {
        $totalCounts = Messages::select(['id'])
            ->leftJoin('products', 'products.id', '=', 'messages.product_id')
            ->leftJoin('users_matches', function($join) use ($userId) {
                $join->on('users_matches.match_id', '=', 'messages.from_id')
                    ->whereRaw("users_matches.product_id = messages.product_id and users_matches.user_id = {$userId} and users_matches.match_id = messages.from_id")
                    ->limit(1);
            })
            ->where('products.user_id', '!=', $userId)
            ->where('to_id', $userId)
            ->where('read', 0)
            ->where('users_matches.is_mute' , 0)
            ->count();
        return $totalCounts;
    }
}
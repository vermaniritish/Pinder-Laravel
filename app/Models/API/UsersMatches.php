<?php
namespace App\Models\API;

use App\Models\AppModel;
use App\Models\Admin\UsersMatches as AdminUsersMatches;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UsersMatches extends AdminUsersMatches
{
	public function matches()
    {
        return $this->belongsTo(Users::class, 'match_id', 'id');
    }

    public function product()
    {
        return $this->belongsTo(Products::class, 'product_id', 'id');
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $where
    */
    public static function getListing(Request $request, $where = [], $limit = 20)
    {
    	$page = $request->get('page') ? $request->get('page') : 1;
    	$search = $request->get('search') ? $request->get('search') : null;
    	$offset = ($page - 1) * $limit;
    	
    	$listing = UsersMatches::select([
    			'users_matches.id',
                'users_matches.product_id',
    			'users_matches.match_id',
                'users_matches.user_id',
    			'users_matches.is_mute',
    			'users_matches.last_message',
    			'users_matches.last_message_date',
    			'users_matches.created',
                'products.title as product_title',
                'products.slug as product_slug',
                'products.image as product_image',
                'products.user_id as product_user_id',
                'products.status',  
                'products.sold',  
                'products.deleted_at',  
                'users.first_name as match_first_name',  
                'users.last_name as match_last_name',  
                'users.image as match_image',
                DB::raw('(select count(id) as unread from messages where messages.from_id = users_matches.match_id and messages.to_id = users_matches.user_id and messages.read = 0 and messages.product_id = users_matches.product_id LIMIT 1) as unread')
	    	])
            ->leftJoin('users', 'users.id', '=', 'users_matches.match_id')
            ->leftJoin('products', 'products.id', '=', 'users_matches.product_id')
            ->where('users_matches.is_delete', 0)
            ->where('users.status', 1)
            ->orderByRaw('users_matches.last_message_date DESC, users_matches.id DESC');

        if($request->unread)
        {
            $listing->havingRaw('unread > 0');
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

	    if(!empty($search))
	    {
	    	$search = "%" . $search . '%';
 	    	$listing->whereRaw('(concat(users.first_name, " ", users.last_name) like ? or users.first_name LIKE ? or users.last_name like ? or products.title like ?)', [$search, $search, $search, $search]);
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

    public static function get($userId, $toId, $productId)
    {
        return UsersMatches::where([
                'user_id' => $userId,
                'match_id' => $toId,
                'product_id' => $productId,
                'is_delete' => 0
            ])
            ->first();
    }

    public static function getByUser($userId)
    {
        $match = UsersMatches::select([
                'users_matches.id',
                'users_matches.product_id',
                'users_matches.match_id',
                'users_matches.user_id',
                'users_matches.last_message',
                'users_matches.last_message_date',
                'users_matches.is_mute',
                'users_matches.created'
            ])
            ->leftJoin('users', 'users.id', '=', 'users_matches.match_id')
            ->leftJoin('products', 'products.id', '=', 'users_matches.product_id')
            ->with([
                'product' => function($query) {
                    $query->select(['id', 'title', 'slug', 'image', 'user_id']);
                },
                'matches' => function($query) {
                    $query->select(['id', 'first_name', 'last_name', 'image']);
                }
            ])
            ->where('users_matches.is_delete', 0)
            ->where('users.status', 1)
            ->where('users_matches.user_id', $userId)
            ->orderByRaw('users_matches.last_message_date DESC, users_matches.id DESC')
            ->first();
        if($match)
        {
            $match->count = Messages::select(['id'])
                ->where('product_id', $match->product_id)
                ->where('from_id', $match->match_id)
                ->where('to_id', $userId)
                ->where('read', 0)
                ->groupBy(['from_id', 'product_id'])
                ->count();
            $match->user_type = $match->product_id == $match->product->user_id ? 'seller' : 'buyer';
        }
        return $match;
    }

    /**
    * To update last message
    * @param $userId
    * @param $toId
    * @param $message Messages
    */
    public static function updateLastMessage($userId, $toId, $message)
    {
    	$matches = UsersMatches::where('product_id', $message->product_id)->whereRaw('((user_id = ? and match_id = ?) or (user_id = ? and match_id = ?))', [$userId, $toId, $toId, $userId])
    		->get();
        if($matches->count() > 0)
        {
        
            foreach ($matches as $key => $match) {  
                $match->is_delete = 0;
                $match->last_message = $message->message;
                $match->last_message_id = $message->id;
                $match->last_message_date = date('Y-m-d H:i:s');
                $match->save();
            }
        }
        else
        {
            UsersMatches::create([
                'product_id' => $message->product_id,
                'user_id' => $userId,
                'match_id' => $toId,
                'last_message' => $message->message,
                'last_message_id' => $message->id,
                'last_message_date' => date('Y-m-d H:i:s'),
                'created' => date('Y-m-d H:i:s'),
                'modified' => date('Y-m-d H:i:s')
            ]);

            UsersMatches::create([
                'product_id' => $message->product_id,
                'user_id' => $toId,
                'match_id' => $userId,
                'last_message' => $message->message,
                'last_message_id' => $message->id,
                'last_message_date' => date('Y-m-d H:i:s'),
                'created' => date('Y-m-d H:i:s'),
                'modified' => date('Y-m-d H:i:s')
            ]);
        }
    }
}
<?php
namespace App\Models\API;

use App\Models\AppModel;

class UsersWishlist extends AppModel
{
    protected $table = 'users_wishlist';
    protected $primaryKey = 'id';
    public $timestamps = false;

    public static function create($productId, $userId)
    {
    	UsersWishlist::remove($productId, $userId);
    	$wishlist = new UsersWishlist();
    	$wishlist->product_id = $productId;
    	$wishlist->user_id = $userId;
    	$wishlist->created = date('Y-m-d H:i:s');
    	if($wishlist->save())
    	{
    		return $wishlist;
    	}
    	else
    	{
    		return null;
    	}
    }

    public static function remove($productId, $userId)
    {
    	return UsersWishlist::where('product_id', $productId)->where('user_id', $userId)->delete();
    }
}
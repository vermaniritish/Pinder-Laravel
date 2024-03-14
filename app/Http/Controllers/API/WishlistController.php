<?php
/**
 * Wishlist Class
 *
 * @package    ProductsController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use App\Models\API\ApiAuth;
use App\Models\API\Products;
use App\Models\API\UsersWishlist;
use App\Models\API\UsersMatches;
use App\Libraries\FileSystem;

class WishlistController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function listing(Request $request)
	{
		$userId = ApiAuth::getLoginId();
		$wishlist = UsersWishlist::where('user_id', $userId)->groupBy('product_id')->pluck('product_id')->toArray();
		$wishlist = !empty($wishlist) ?  implode(',', $wishlist) : implode(',', [0]);
		
		$where = ['products.id in ('.$wishlist.')'];
		$products = Products::getListing($request, $where);
		$items = $products->items();
		if($userId)
		{
			foreach ($items as $key => $value) {
				$items[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
				$items[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
			}
		}

	    return Response()->json([
	    	'status' => true,
            'products' => $items,
            'page' => $products->currentPage(),
            'counter' => $products->perPage(),
            'count' => $products->total(),
            'pagination_counter' => $products->currentPage() * $products->perPage()
        ], 200);
	}

	function remove(Request $request)
	{
		$validator = Validator::make(
            $request->toArray(),
            [
            	'product_id' => 'required'
            ]
        );

        if(!$validator->fails())
	    {
			$userId = ApiAuth::getLoginId();
			$wishlist = UsersWishlist::where('user_id', $userId)->where('product_id', $request->get('product_id'))->first();
			if($wishlist->delete())
			{
				$user = ApiAuth::getLoginUser();
				$user->wishlist = UsersWishlist::where('user_id', $user->id)->pluck('product_id')->toArray();
				return Response()->json([
		    			'status' => true,
		    			'message' => 'Product removed from wishlist.',
		    			'user' => $user
		    		]);
			}
			else
			{
				return Response()->json([
		    			'status' => false,
		    			'message' => 'Product could not removed from wishlist.'
		    		], 400);	
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		}
	}
}
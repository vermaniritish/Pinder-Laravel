<?php
/**
 * Products Class
 *
 * @package    ProductsController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController;
use App\Http\Resources\ProductsResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\API\ApiAuth;
use App\Models\API\Products;
use App\Models\API\ProductCategories;
use App\Models\API\UsersWishlist;
use App\Models\API\ProductReports;
use App\Models\API\Orders;
use App\Models\Admin\Settings;

use App\Libraries\FileSystem;
use App\Libraries\DateTime;
use Illuminate\Http\Response;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class ProductsController extends BaseController
{
	/**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
	public function index(Request $request)
	{
		$products = Products::with('categories')
			->orderBy($request->get('sortBy') ? $request->get('sortBy') : 'id', $request->get('direction') ? $request->get('direction') : 'asc')
			->where('title', 'like', '%' . $request->get('query') . '%')
			->orWhereHas('categories', function ($query) use ($request) {
				$query->where('product_category_relation.category_id', 'like', '%' . $request->get('query') . '%');
			})
			->paginate($request->get('per_page'));
	
		return ProductsResource::collection($products);
	}
	

	/**
     * Display the specified resource.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        $check_brand = Products::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('PRODUCT_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->success(new ProductsResource($check_brand), Response::HTTP_OK);
    }

	function categories(Request $request)
	{
		$where = [];
		$items = ProductCategories::select([
                'product_categories.id',
                'product_categories.title',
                'product_categories.slug',
                'product_categories.image'
            ])
            ->orderBy('product_categories.title', 'asc')
            ->get();
	    return Response()->json([
	    	'status' => true,
            'categories' => $items
        ], 200);
	}

	function makeWishlist(Request $request)
	{
		$validator = Validator::make(
            $request->toArray(),
            [
            	'id' => 'required',
            	'wishlist' => 'required',
            ]
        );

        
		if(!$validator->fails())
		{
			$product = Products::select(['id', 'slug'])->where('id', $request->get('id'))->first();
			if($product)
			{
				$userId = ApiAuth::getLoginId();

				if($request->get('wishlist'))
				{
					$wishlist = UsersWishlist::create($request->get('id'), $userId);
					if($wishlist)
					{
						$user = ApiAuth::getLoginUser();
						$user->wishlist = UsersWishlist::where('user_id', $user->id)->pluck('product_id')->toArray();
						return Response()->json([
					    	'status' => true,
					    	'message' => 'Product added to your wishlist.',
				            'wishlist' => $request->get('wishlist'),
				            'product' => Products::getBySlug($product->slug),
				            'user' => $user
				        ]);
					}
					else
					{
						return Response()->json([
					    	'status' => false,
					    	'message' => 'Product could not mark as wishlist.'
				        ], 400);
					}
				}
				else
				{
					$wishlist = UsersWishlist::remove($request->get('id'), $userId);
					if($wishlist)
					{
						$user = ApiAuth::getLoginUser();
						$user->wishlist = UsersWishlist::where('user_id', $user->id)->pluck('product_id')->toArray();
						
						return Response()->json([
					    	'status' => true,
					    	'message' => 'Product removed from your wishlist.',
				            'wishlist' => $request->get('wishlist'),
				            'user' => $user
				        ]);
					}
					else
					{
				        return Response()->json([
					    	'status' => false,
					    	'message' => 'Product could not remove from wishlist.',
				        ], 400);
					}	
				}
				
			}
			else
			{
				return Response()->json([
			    	'status' => false,
		            'message' => 'Product is missing.'
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


	function getSlots(Request $request)
	{
		$maxOrders = Settings::get('max_orders_per_hour');
		$duration = Settings::get('duration');
		$duration = $duration ? json_decode($duration) : null;
		$dates = DateTime::getDatesBetweenTwoDates(
			date('Y-m-d'), 
			strtotime('+1 hour') >= strtotime($duration[1]) ? date('Y-m-d', strtotime('+3 days')) : date('Y-m-d', strtotime('+2 days'))
		);
		$final = [];
		foreach($dates as $d)
		{
			$disabled = Orders::select([DB::raw('TIME_FORMAT(booking_time, \'%h:%i %p\') as booking_time'), DB::raw('count(booking_time) as c')])
			->whereNotIn('status', ['cancel', 'canceled'])
			->where('booking_date', date('Y-m-d', $d))
			->groupBy('booking_time')
			->havingRaw('c >= ' . $maxOrders)
			->pluck('booking_time')
			->toArray();
			if(date('Y-m-d', $d) == date('Y-m-d') && strtotime('+1 hour') >= strtotime($duration[1]))  {
				continue;
			}
			
			$final[] = [
				'day' => date('D', $d),
				'd' => date('d', $d),
				'date' => date('Y-m-d', $d),
				'time' => DateTime::calculateTimeDifference(date('Y-m-d', $d) == date('Y-m-d') && time() > strtotime(date('Y-m-d') . ' ' . $duration[0]) ? (date('H', strtotime('+1 hour')) . ':' . (round(date('H', strtotime('+1 hour'))/30)*30) )  : $duration[0], $duration[1]),
				'disabled' => $disabled
			];
		}
		return Response()->json([
			'dates' => $final
		]);
	}
}
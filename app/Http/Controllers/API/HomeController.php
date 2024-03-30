<?php
/**
 * Home Class
 *
 * @package    HomeController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\Admin\Settings;
use App\Libraries\General;
use App\Libraries\PositionStack;
use App\Models\API\SearchSugessions;
use App\Models\API\Products;
use App\Models\API\ApiAuth;
use App\Models\API\UsersMatches;
use App\Models\API\ProductCategories;
use App\Models\Admin\ProductCategoryRelation;
use App\Models\Admin\SearchKeywords;
use Illuminate\Support\Facades\DB;
use App\Libraries\FileSystem;

class HomeController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function productsListing(Request $request)
	{
		$where = ['products.status' => 1];
		$products = Products::getListing($request, $where);
		$items = $products->items();
		return Response()->json([
			'status' => true,
			'products' => $items,
			'page' => $products->currentPage(),
			'counter' => $products->perPage(),
			'count' => $products->total(),
			'maxPage' => ceil($products->total()/$products->perPage()),
			'paginationMessage' => "Showing {$products->firstItem()} - {$products->lastItem()} of {$products->total()} results"

		]);
	}

	function productDetails(Request $request, $slug)
	{
		$userId = ApiAuth::getLoginId();
		$product = Products::getBySlug($slug);
		if($product)
		{
			$product->description = nl2br($product->description);
			$product->user_image = $product->users && $product->users->image ? $product->users->image : null;
			$catIds = $product->categories()->pluck('category_id')->toArray();
			$similarProducts = [];
			if(!empty($catIds))
			{
				$productIds = ProductCategoryRelation::whereIn('category_id', $catIds)
					->where('product_id', '!=', $product->id)
					->groupBy('product_id')
					->pluck('product_id')
					->toArray();
				if(!empty($productIds))
				{
					$where = ["products.id in (".implode(',', array_unique($productIds)).")", "products.status" => 1, 'sold' => 0];
					$similarProducts = Products::getListing($request, $where);
					if($userId)
					{
						foreach ($similarProducts as $key => $value) {
							$similarProducts[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
							$similarProducts[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
						}
					}
				}
			}
			
			$respond = DB::select('SELECT AVG(TIMESTAMPDIFF(MINUTE, created, read_at)) as response_seconds from messages where to_id = ' . $product->user_id . ' and read_at is not null;');
			$respond = $respond && $respond[0] && $respond[0]->response_seconds ? $respond[0]->response_seconds : null;
			return Response()->json([
		    	'status' => true,
	    		'product' => $product,
	    		'similar_products' => $similarProducts,
	    		'respond' => $respond
		    ]);
		}
		else
		{
			return Response()->json([
		    	'status' => false,
	    		'message' => 'Not Found!'
		    ], 400);
		}
	}
}
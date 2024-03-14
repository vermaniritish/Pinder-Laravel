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

	function information(Request $request)
	{
		$userId = ApiAuth::getLoginId();
		// $sugessions = [];
		// if(Settings::get('home_page_search_sugession'))
		// {
		// 	$sugessions = SearchSugessions::select([
		// 			'search_sugessions.id',
		// 			'search_sugessions.title',
		// 			'search_sugessions.slug',
		// 			'search_sugessions.image'
		// 		])
		// 		->where('status', 1)
		// 		->orderBy('search_sugessions.id', 'asc')
		// 		->get();
		// }

		// $similarProducts = Products::getSimilarListing($request, ["products.status" => 1, 'sold' => 0]);

		// if($userId)
		// {
		// 	foreach ($similarProducts as $key => $value) {
		// 		$similarProducts[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
		// 		$similarProducts[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
		// 	}
		// }
		// $similarProducts = $similarProducts->items();

		return Response()->json([
		    	'status' => true,
	    		'layout' => Settings::get('home_page_layout'),
	    		'banner' => Settings::get('home_page_banner'),
	    		'text' => Settings::get('home_page_text'),
	    		'mission_title' => Settings::get('mission_title'),
	    		'mission_description' => Settings::get('mission_description'),
	    		'mission_image' => Settings::get('mission_image'),
	    		'search_text' => Settings::get('home_page_search_text'),
	    		'sugessions' => [],
	    		'similarProducts' => []
		    ]);
	}

	function sugessions()
	{
		$sugessions = [];
		if(Settings::get('home_page_search_sugession'))
		{
			$sugessions = SearchSugessions::select([
					'search_sugessions.id',
					'search_sugessions.title',
					'search_sugessions.slug',
					'search_sugessions.image'
				])
				->where('status', 1)
				->orderBy('search_sugessions.id', 'asc')
				->get();
		}

		return Response()->json([
			'status' => true,
			'sugessions' => $sugessions,
		]);
	}

	function spotlight(Request $request)
	{
		$userId = ApiAuth::getLoginId();
		$similarProducts = Products::getSimilarListing($request, ["products.status" => 1, 'sold' => 0]);

		if($userId)
		{
			foreach ($similarProducts as $key => $value) {
				$similarProducts[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
				$similarProducts[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
			}
		}
		$similarProducts = $similarProducts->items();
		return Response()->json([
		    	'status' => true,
	    		'similarProducts' => $similarProducts
		    ]);
	}

	function footerLinks(Request $request)
	{
		$links = [
			'blog' => Settings::get('blog_link'),
			'support' => Settings::get('support_link'),
			'privacy_policy' => Settings::get('privacy_policy_link'),
			'terms_of_service' => Settings::get('terms_of_service_link'),
		];

		return Response()->json([
		    	'status' => true,
		    	'links' => $links
		    ]);
	}

	function products(Request $request)
	{
		$products = [];
		if($request->get('search'))
		{
			$search = $request->get('search');

			$products = SearchKeywords::select([
				'search_keywords.keywords as title'
			])
			->leftJoin('products', 'products.id', '=', 'search_keywords.product_id')
			->whereRaw('search_keywords.keywords LIKE ?', ["%{$search}%"])
			->where([
				'products.status' => 1,
				'products.sold' => 0
			])
			->groupBy('search_keywords.keywords')
			->orderBy('search_keywords.id', 'asc')
			->limit(50)
			->get();
		}
		
		return Response()->json([
		    	'status' => true,
	    		'products' => $products
		    ]);
	}

	function address(Request $request)
	{
		$address = [];
		if($request->get('search'))
		{
			$search = $request->get('search');
			$address = Products::select([
					'postcode as label'
				])
				->where('postcode', 'LIKE', $search . '%')
				->groupBy('postcode')
				->limit(40)
				->get();
			
			if($address->count() < 1)
			{
				$address = Products::select([
						'address as label'
					])
					->where('address', 'LIKE', '%' . $search . '%')
					->groupBy('address')
					->limit(40)
					->get();
			}
		}
		
		return Response()->json([
		    	'status' => true,
	    		'address' => $address
		    ]);
	}

	function productsListing(Request $request)
	{
		$userId = ApiAuth::getLoginId();	
		$where = ["products.status" => 1, 'sold' => 0];
		$products = Products::getListing($request, $where);
		$items = $products->items();
		if($userId)
		{
			foreach ($items as $key => $value) {
				$items[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
				$items[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
			}
		}

		$categories = [];
		if($request->get('categories'))
		{
			foreach($request->get('categories') as $k => $v)
			{
				$categories[] = ProductCategories::get($v);
			}
		}

		$similarProducts = [];
		if(!$request->get('page') || $request->get('page') == '1')
		{
			$similarProducts = Products::getSimilarListing($request, $where);
			if($similarProducts->count() < 1)
			{
				$similarProducts = Products::getSimilarListing($request, $where, 'location_only');
			}

			if($userId)
			{
				foreach ($similarProducts as $key => $value) {
					$similarProducts[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
					$similarProducts[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
				}
			}
			$similarProducts = $similarProducts->items();
		}

	    return Response()->json([
	    	'status' => true,
            'products' => $items,
            'categories' => $categories,
            'page' => $products->currentPage(),
            'counter' => $products->perPage(),
            'count' => $products->total(),
            'pagination_counter' => $products->currentPage() * $products->perPage(),
            'similarProducts' => $similarProducts
        ], 200);
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
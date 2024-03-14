<?php

/**
 * Products Class
 *
 * @package    ProductsController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin\Products;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Settings;
use App\Models\Admin\Permissions;
use App\Models\Admin\AdminAuth;
use App\Libraries\General;
use App\Models\Admin\Products;
use App\Models\Admin\ProductCategories;
use App\Models\Admin\ProductCategoryRelation;
use App\Models\Admin\Admins;
use App\Models\Admin\Shops;
use App\Models\Admin\Users;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;
use App\Libraries\FileSystem;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\BrandProducts;
use App\Models\Admin\Brands;

class ProductsController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('products', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(products.title LIKE ? or shop_owner.first_name LIKE ? or shop_owner.last_name LIKE ? or products.address LIKE ? or products.postcode LIKE ?)'] = [$search, $search, $search, $search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['products.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['products.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    	}
    	
    	// if($request->get('shop_id') && !empty(array_filter($request->get('shop_id'))) )
    	// {
    	// 	$shops = $request->get('shop_id');
    	// 	$shops = $shops ? implode(',', $shops) : 0;
    	// 	$where[] = 'products.shop_id IN ('.$shops.')';
    	// }

    	if($request->get('category'))
    	{
    		$ids = ProductCategoryRelation::distinct()->whereIn('category_id', $request->get('category'))->pluck('product_id')->toArray();
    		$ids = !empty($ids) ? implode(',', $ids) : '0';
    		$where[] = 'products.id IN ('.$ids.')';
    	}

		if($request->get('brands'))
    	{
    		$ids = BrandProducts::distinct()->whereIn('brand_id', $request->get('brand'))->pluck('product_id')->toArray();
    		$ids = !empty($ids) ? implode(',', $ids) : '0';
    		$where[] = 'products.id IN ('.$ids.')';
    	}

    	if($request->get('status'))
    	{
    		switch ($request->get('status')) {
    			case 'active':
    				$where['products.status'] = 1;
    			break;
    			case 'non_active':
    				$where['products.status'] = 0;
    			break;
    		}	
    	}

    	$listing = Products::getListing($request, $where);

    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/products/listingLoop", 
	    		[
	    			'listing' => $listing
	    		]
	    	)->render();

		    return Response()->json([
		    	'status' => 'success',
	            'html' => $html,
	            'page' => $listing->currentPage(),
	            'counter' => $listing->perPage(),
	            'count' => $listing->total(),
	            'pagination_counter' => $listing->currentPage() * $listing->perPage()
	        ], 200);
		}
		else
		{
			$filters = $this->filters();
	    	return view(
	    		"admin/products/index", 
	    		[
	    			'listing' => $listing,
	    			'categories' => $filters['categories'],
					'brands' => $filters['brands'],
	    			'shops' => $filters['shops']
	    		]
	    	);
	    }
    }

    function filters()
    {
    	$catIds = ProductCategoryRelation::distinct()->pluck('category_id')->toArray();
    	$categories = [];
    	if($catIds)
    	{
			$categories = ProductCategories::getAllCategorySubCategory($catIds);
		}
    	$shops = Shops::getAll(
    		[
    			'shops.id',
    			'shops.name',
    			'shops.status',
    			'users.first_name',
    			'users.last_name'
    		],
    		[
    		],
    		'concat(shops.name) desc'
    	);
    
		$brands = Brands::getAll(
			[
				'brands.id',
				'brands.title'
			],
			[
			],
			'brands.title desc'
		);

    	return [
    		'categories' => $categories,
    		'shops' => $shops,
			'brands' => $brands
    	];
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('products', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$product = Products::get($id);
    	if($product)
    	{
	    	return view("admin/products/view", [
    			'product' => $product
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function add(Request $request)
    {
    	if(!Permissions::hasPermission('products', 'create'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	if($request->isMethod('post'))
    	{
    		$data = $request->toArray();
    		unset($data['_token']);
			if (isset($data['tags']) && $data['tags']) {
				$data['tags'] = explode(',', $data['tags']);
			}
    		$validator = Validator::make(
	            $data,
	            [
	                'title' => 'required',
	                'description' => 'nullable',
					'duration_of_service' => ['nullable'],
					'price' => ['required', 'numeric', 'min:0'],
					'sale_price' => ['nullable', 'numeric', 'min:0'],
	                'category' => 'required',
	                'brand' => 'required',
					'tags' => ['nullable', 'array'],
					'tags.*' => ['string','max:20',],
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$categories = [];
				$brands = [];
	        	if(isset($data['category']) && $data['category']) {
	        		$categories = $data['category'];
	        	}
				if(isset($data['brand']) && $data['brand']) {
	        		$brands = $data['brand'];
	        	}
	        	unset($data['category']);
	        	unset($data['brand']);
	        	$product = Products::create($data);
	        	if($product)
	        	{
	        		if(!empty($categories))
	        		{  
	        			Products::handleCategories($product->id, $categories);
	        		}
					if(!empty($brands))
	        		{
	        			Products::handleBrands($product->id, $brands);
	        		}

	        		$request->session()->flash('success', 'Product created successfully.');
	        		return redirect()->route('admin.products');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Product could not be save. Please try again.');
		    		return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}
	    
	    $categories = ProductCategories::getAll(
	    		[
	    			'product_categories.id',
	    			'product_categories.title'
	    		],
	    	    [
					'status' => 1,
				],
	    		'product_categories.title desc'
	    	);

		$brands = Brands::getAll(
	    		[
	    			'brands.id',
	    			'brands.title'
	    		],
	    	    [
					'status' => 1, 
				],
	    		'brands.title desc'
	    	);

	    $users = Users::getAll(
	    		[
	    			'users.id',
	    			'users.first_name',
	    			'users.last_name',
	    			'users.status',
	    		],
	    		[
	    		],
	    		'concat(users.first_name, users.last_name) desc'
	    	);
	
	    return view("admin/products/add", [
	    			'categories' => $categories,
	    			'users' => $users,
					'brands' => $brands
	    		]);
    }

    function edit(Request $request, $id)
    {
    	if(!Permissions::hasPermission('products', 'update'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}
    	$product = Products::get($id);
    	if($product)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
				if (isset($data['tags']) && $data['tags']) {
					$data['tags'] = explode(',', $data['tags']);
				}
	    		$validator = Validator::make(
		            $data,
			            [
							'title' => 'required',
							'description' => 'nullable',
							'duration_of_service' => ['nullable'],
							'price' => ['required', 'numeric', 'min:0'],
							'sale_price' => ['nullable', 'numeric', 'min:0'],
							'category' => [
								'required',
								'array',
								Rule::exists(ProductCategories::class, 'id')->where(function ($query) {
									$query->where('status', 1);
							})],
							'brand' => ['required', 'array', Rule::exists(Brands::class, 'id')->where(function ($query) {
								$query->where('status', 1);
							})],
							'tags' => ['nullable', 'array'],
							'tags.*' => ['string','max:20',],
		            ]
		        );
		        if(!$validator->fails())
		        {
		        	unset($data['_token']);
	        		/** ONLY IN CASE OF MULTIPLE IMAGE USE THIS **/
	        		if(isset($data['image']) && $data['image'])
	        		{
	        			$data['image'] = json_decode($data['image'], true);
	        			$product->image = $product->image ? json_decode($product->image) : [];
		        		$data['image'] = array_merge($product->image, $data['image']);
		        		$data['image'] = json_encode($data['image']);
		        	}
		        	else
		        	{
		        		unset($data['image']);
		        	}
		        	/** ONLY IN CASE OF MULTIPLE IMAGE USE THIS **/

		        	$categories = [];
					$brands = [];
		        	if(isset($data['category']) && $data['category']) {
		        		$categories = $data['category'];
		        	}
					if(isset($data['brand']) && $data['brand']) {
						$brands = $data['brand'];
					}
		        	unset($data['category']);
		        	unset($data['brand']);

		        	if(Products::modify($id, $data))
		        	{
		        		if(!empty($categories))
		        		{
		        			Products::handleCategories($product->id, $categories);
		        		}
						if(!empty($brands))
		        		{
		        			Products::handleBrands($product->id, $brands);
		        		}
		        		$request->session()->flash('success', 'Product updated successfully.');
		        		return redirect()->route('admin.products');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Product could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			$categories = ProductCategories::getAll(
	    		[
	    			'product_categories.id',
	    			'product_categories.title'
	    		],
				[
					'status' => 1, 
				],
	    		'product_categories.title desc'
	    	);

	    	$users = Users::getAll(
	    		[
	    			'users.id',
	    			'users.first_name',
	    			'users.last_name',
	    			'users.status',
	    		],
	    		[
	    		],
	    		'concat(users.first_name, users.last_name) desc'
	    	);

			$brands = Brands::getAll(
	    		[
	    			'brands.id',
	    			'brands.title'
	    		],
	    	    [
					'status' => 1, 
				],
	    		'brands.title desc'
	    	);

			return view("admin/products/edit", [
    			'product' => $product,
    			'categories' => $categories,
    			'users' => $users,
				'brands' => $brands
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('products', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}
    	
    	if(Products::remove($id))
    	{
    		$request->session()->flash('success', 'Product deleted successfully.');
    		return redirect()->route('admin.products');
    	}
    }

    function bulkActions(Request $request, $action)
    {
    	if( ($action != 'delete' && !Permissions::hasPermission('products', 'update')) || ($action == 'delete' && !Permissions::hasPermission('products', 'delete')) ) 
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$ids = $request->get('ids');
    	if(is_array($ids) && !empty($ids))
    	{
    		switch ($action) {
    			case 'active':
    				Products::modifyAll($ids, [
    					'status' => 1
    				]);
    				$message = count($ids) . ' records has been published.';
    			break;
    			case 'inactive':
    				Products::modifyAll($ids, [
    					'status' => 0
    				]);
    				$message = count($ids) . ' records has been unpublished.';
    			break;
    			case 'delete':
    				Products::removeAll($ids);
    				$message = count($ids) . ' records has been deleted.';
    			break;
    		}

    		$request->session()->flash('success', $message);

    		return Response()->json([
    			'status' => 'success',
	            'message' => $message,
	        ], 200);		
    	}
    	else
    	{
    		return Response()->json([
    			'status' => 'error',
	            'message' => 'Please select atleast one record.',
	        ], 200);	
    	}
    }
}

<?php

/**
 * Pages Class
 *
 * @package    PagesController 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Permissions;
use App\Models\Admin\Staffs;
use App\Models\Admin\Admins;
use Illuminate\Validation\Rule;
use App\Libraries\FileSystem;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\Colours;
use App\Models\Admin\Orders;
use App\Models\Admin\Ratings;
use App\Models\Admin\Settings;

class RatingsController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('ratings', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(
				ratings.id LIKE ? or
				ratings.color_code LIKE ?)'] = [$search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['ratings.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['ratings.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    	}

    	if($request->get('admins'))
    	{
    		$admins = $request->get('admins');
    		$admins = $admins ? implode(',', $admins) : 0;
    		$where[] = 'ratings.created_by IN ('.$admins.')';
    	}

    	$listing = Ratings::getListing($request, $where);


    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/ratings/listingLoop", 
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
			$filters = $this->filters($request);
	    	return view(
	    		"admin/ratings/index", 
	    		[
	    			'listing' => $listing,
	    			'admins' => $filters['admins']
	    		]
	    	);
	    }
    }

    function filters(Request $request)
    {
		$admins = [];
		$adminIds = Ratings::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
		if($adminIds)
		{
	    	$admins = Admins::getAll(
	    		[
	    			'admins.id',
	    			'admins.first_name',
	    			'admins.last_name',
	    			'admins.status',
	    		],
	    		[
	    			'admins.id in ('.implode(',', $adminIds).')'
	    		],
	    		'concat(admins.first_name, admins.last_name) desc'
	    	);
	    }
    	return [
	    	'admins' => $admins
    	];
    }

    function add(Request $request)
    {
    	if(!Permissions::hasPermission('ratings', 'create'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	if($request->isMethod('post'))
    	{
    		$data = $request->toArray();
    		unset($data['_token']);
    		$validator = Validator::make(
	            $request->toArray(),
				[
					'name' => 'required|string|max:255',
					'designation' => 'string|max:255',
					'rating' => 'required|numeric|min:1|max:5', 
					'message' => 'required|string|max:500',
					'image_status' => 'nullable|boolean',
				],
	        );
	        if(!$validator->fails())
	        {
	        	$page = Ratings::create($data);
	        	if($page)
	        	{
	        		$request->session()->flash('success', 'Rating created successfully.');
	        		return redirect()->route('admin.ratings');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Rating could not be save. Please try again.');
		    		return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}
	    return view("admin/ratings/add", [
	    		]);
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('ratings', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}
		$fromDate = now()->startOfMonth()->toDateString();
		$toDate = now()->endOfMonth()->toDateString();
		if ($request->filled('order_created')) {
			$customDateRange = $request->input('order_created');
			$fromDate = $customDateRange[0];
			$toDate = $customDateRange[1];
		}	
		if($fromDate && $toDate)
    	{
    		if(isset($fromDate) && !empty($fromDate))
    			$where['ratings.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($fromDate))
    			];
    		if(isset($toDate) && !empty($toDate))
    			$where['ratings.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($toDate))
    			];
    	}
    	$page = Ratings::get($id);
		$where['staff_id'] = $id;
		if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(
				ratings.status LIKE ? or
				ratings.id LIKE ? or
				ratings.total_amount LIKE ?)'] = [$search, $search, $search];
    	}
		$listing = Orders::getListing($request,$where);
    	if($page)
    	{	if($request->ajax())
			{
				$html = view(
					"admin/ratings/orders/listingLoop", 
					[
						'listing' => $listing,
						'currency' => Settings::get('currency_symbol'),
						'status' => Orders::getStaticData()['status'],
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
	    	return view("admin/ratings/view", [
    			'page' => $page,
				'status' => Orders::getStaticData()['status'],
				'listing' => $listing
    		]);}
		}
		else
		{
			abort(404);
		}
    } 

    function edit(Request $request, $id)
    {
    	if(!Permissions::hasPermission('ratings', 'update'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$page = Ratings::get($id);

    	if($page)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
	    		$validator = Validator::make(
		            $request->toArray(),
					[
						'color_code' => ['required','regex:/^#[a-fA-F0-9]{6}$/', Rule::unique('colours','color_code')->ignore($id)->whereNull('deleted_at'), ],
						'image' => ['nullable'],
					],
					[
						'color_code.required' => 'The colour code is required.',
						'color_code.regex' => 'The colour code must be in the format #RRGGBB (e.g., #FF0000 for red).',
					]
		        );

		        if(!$validator->fails())
		        {
		        	unset($data['_token']);
	        		
		        	/** IN CASE OF SINGLE UPLOAD **/
		        	if(isset($data['image']) && $data['image'])
		        	{
		        		$oldImage = $page->image;
		        	}
		        	else
		        	{
		        		unset($data['image']);
		        		
		        	}
		        	/** IN CASE OF SINGLE UPLOAD **/
		        	if(Ratings::modify($id, $data))
		        	{
		        		/** IN CASE OF SINGLE UPLOAD **/
		        		if(isset($oldImage) && $oldImage)
		        		{
		        			FileSystem::deleteFile($oldImage);
		        		}
		        		/** IN CASE OF SINGLE UPLOAD **/

		        		$request->session()->flash('success', 'Colour updated successfully.');
		        		return redirect()->route('admin.ratings');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Rating could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			return view("admin/ratings/edit", [
    			'page' => $page
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('ratings', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = Ratings::find($id);
    	if($admin->delete())
    	{
    		$request->session()->flash('success', 'Staff deleted successfully.');
    		return redirect()->route('admin.ratings');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Staff could not be delete.');
    		return redirect()->route('admin.ratings');
    	}
    }

    function bulkActions(Request $request, $action)
    {
    	if( ($action != 'delete' && !Permissions::hasPermission('ratings', 'update')) || ($action == 'delete' && !Permissions::hasPermission('ratings', 'delete')) )
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$ids = $request->get('ids');
    	if(is_array($ids) && !empty($ids))
    	{
    		switch ($action) {
    			case 'active':
    				Ratings::modifyAll($ids, [
    					'status' => 1
    				]);
    				$message = count($ids) . ' records has been published.';
    			break;
    			case 'inactive':
    				Ratings::modifyAll($ids, [
    					'status' => 0
    				]);
    				$message = count($ids) . ' records has been unpublished.';
    			break;
    			case 'delete':
    				Ratings::removeAll($ids);
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

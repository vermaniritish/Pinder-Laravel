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
use App\Models\Admin\Admins;
use Illuminate\Validation\Rule;
use App\Libraries\FileSystem;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\Colours;
use App\Models\Admin\Orders;
use App\Models\Admin\Settings;
use App\Models\Admin\Sizes;
use App\Models\Admin\StaffDocuments;
use Illuminate\Support\Facades\File;
use Intervention\Image\Size;

class SizeController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('sizes', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}
		$male = Sizes::where('type','Male')->select(['type','id','size_title','from_cm','to_cm','chest','waist','hip','length'])->get();
		$female = Sizes::where('type','Female')->select(['type','id','size_title','from_cm','to_cm','chest','waist','hip','length'])->get();
		$unisex = Sizes::where('type','Unisex')->select(['type','id','size_title','from_cm','to_cm','chest','waist','hip','length'])->get();
    	$where = [];
		$filters = $this->filters($request);
		return view(
			"admin/sizes/index", 
			[
				'male' => $male,
				'female' => $female,
				'unisex' => $unisex,
				'admins' => $filters['admins']
			]
		);
    }

    function filters(Request $request)
    {
		$admins = [];
		$adminIds = Sizes::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
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
    	if(!Permissions::hasPermission('sizes', 'create'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	if($request->isMethod('post'))
    	{
    		$data = $request->toArray();
    		unset($data['_token']);
			if (!empty($data)) {
				$validator = Validator::make($request->all(), [
					'type' => ['required', Rule::in(['Male','Female','Unisex'])],
					'mens.*.size_title' => ['distinct','required','string','max:255'], 
					'mens.*.from_cm' => 'required|numeric|min:0',
					'mens.*.to_cm' => 'required|numeric|min:0',
					'mens.*.chest' => 'required|numeric|min:0',
					'mens.*.waist' => 'required|numeric|min:0',
					'mens.*.hip' => 'required|numeric|min:0',
					'mens.*.length' => 'required|numeric|min:0',
				]);
				if(!$validator->fails())
				{
					Sizes::where('type',$data['type'])->delete();
					foreach ($request->mens as $item) {
							$item['type'] = $data['type'];
							Sizes::create($item);
					}
						$request->session()->flash('success', 'Size created successfully.');
						return redirect()->route('admin.size');
				}
				else
				{
					$request->session()->flash('error', 'Please provide valid inputs.');
					return redirect()->back()->withErrors($validator)->withInput();
				}
			}
			else {
				$request->session()->flash('error', 'Please provide valid inputs.');
				return redirect()->back()->withErrors(['mens' => 'Data is empty.'])->withInput();
			}
		}

	    return view("admin/sizes/add", [
	    		]);
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('sizes', 'listing'))
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
    			$where['orders.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($fromDate))
    			];
    		if(isset($toDate) && !empty($toDate))
    			$where['orders.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($toDate))
    			];
    	}
    	$page = Sizes::get($id);
		$where['staff_id'] = $id;
		if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(
				orders.status LIKE ? or
				orders.id LIKE ? or
				orders.total_amount LIKE ?)'] = [$search, $search, $search];
    	}
		$listing = Orders::getListing($request,$where);
    	if($page)
    	{	if($request->ajax())
			{
				$html = view(
					"admin/sizes/orders/listingLoop", 
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
	    	return view("admin/sizes/view", [
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

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('sizes', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = Sizes::find($id);
    	if($admin->delete())
    	{
    		$request->session()->flash('success', 'Staff deleted successfully.');
    		return redirect()->route('admin.size');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Staff could not be delete.');
    		return redirect()->route('admin.size');
    	}
    }

}

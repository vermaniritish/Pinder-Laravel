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
use App\Models\Admin\Settings;
use App\Models\Admin\Staff;
use App\Models\Admin\StaffDocuments;
use Illuminate\Support\Facades\File;

class ColourController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('colours', 'listing'))
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
				colours.id LIKE ? or
				colours.first_name LIKE ? or
				colours.last_name LIKE ? or
				colours.aadhar_card_number LIKE ? or
				colours.phone_number LIKE ? or
				colours.email LIKE ? or
			 	owner.first_name LIKE ? or 
				owner.last_name LIKE ?)'] = [$search, $search, $search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['colours.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['colours.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    	}

    	if($request->get('admins'))
    	{
    		$admins = $request->get('admins');
    		$admins = $admins ? implode(',', $admins) : 0;
    		$where[] = 'colours.created_by IN ('.$admins.')';
    	}

    	$listing = Colours::getListing($request, $where);


    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/colours/listingLoop", 
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
	    		"admin/colours/index", 
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
		$adminIds = Colours::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
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
    	if(!Permissions::hasPermission('colours', 'create'))
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
					'color_code' => 'required|regex:/^#[a-fA-F0-9]{6}$/',
					'image' => ['nullable'],
				],
				[
					'color_code.required' => 'The colour code is required.',
					'color_code.regex' => 'The colour code must be in the format #RRGGBB (e.g., #FF0000 for red).',
				]
	        );
	        if(!$validator->fails())
	        {
	        	$page = Colours::create($data);
	        	if($page)
	        	{
	        		$request->session()->flash('success', 'Colour created successfully.');
	        		return redirect()->route('admin.colours');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Colour could not be save. Please try again.');
		    		return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}

	    return view("admin/colours/add", [
	    		]);
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('colours', 'listing'))
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
    	$page = Colours::get($id);
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
					"admin/colours/orders/listingLoop", 
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
	    	return view("admin/colours/view", [
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
    	if(!Permissions::hasPermission('colours', 'update'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$page = Colours::get($id);

    	if($page)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
	    		$validator = Validator::make(
		            $request->toArray(),
		            [
						'first_name' => 'required',
						'last_name' => 'required',
						'email' => [
							'required',
							'email',
							Rule::unique('staff','email')->whereNull('deleted_at'),
						],
						'phone_number' => ['required','numeric','digits:10',],
						'aadhar_card_number' => ['required', 'numeric', 'digits:12',],
						'image' => ['nullable'],
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
		        	if(Colours::modify($id, $data))
		        	{
		        		/** IN CASE OF SINGLE UPLOAD **/
		        		if(isset($oldImage) && $oldImage)
		        		{
		        			FileSystem::deleteFile($oldImage);
		        		}
		        		/** IN CASE OF SINGLE UPLOAD **/

		        		$request->session()->flash('success', 'Colour updated successfully.');
		        		return redirect()->route('admin.colours');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Colour could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			return view("admin/colours/edit", [
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
    	if(!Permissions::hasPermission('colours', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = Colours::find($id);
    	if($admin->delete())
    	{
    		$request->session()->flash('success', 'Staff deleted successfully.');
    		return redirect()->route('admin.colours');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Staff could not be delete.');
    		return redirect()->route('admin.colours');
    	}
    }

    function bulkActions(Request $request, $action)
    {
    	if( ($action != 'delete' && !Permissions::hasPermission('colours', 'update')) || ($action == 'delete' && !Permissions::hasPermission('colours', 'delete')) )
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$ids = $request->get('ids');
    	if(is_array($ids) && !empty($ids))
    	{
    		switch ($action) {
    			case 'active':
    				Colours::modifyAll($ids, [
    					'status' => 1
    				]);
    				$message = count($ids) . ' records has been published.';
    			break;
    			case 'inactive':
    				Colours::modifyAll($ids, [
    					'status' => 0
    				]);
    				$message = count($ids) . ' records has been unpublished.';
    			break;
    			case 'delete':
    				Colours::removeAll($ids);
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

    function addDocument(Request $request, $id)
    {
        if(!Permissions::hasPermission('colours', 'create'))
        {
            $request->session()->flash('error', 'Permission denied.');
            return redirect()->route('admin.dashboard');
        }
        $staff = Colours::findOrFail($id);
        $data = $request->toArray();
        unset($data['_token']);
        $validator = Validator::make(
            $request->toArray(),
            [
                'title' => ['required'],
                'file' =>['required', 'json'],          
            ]
        );
        if (!$validator->fails()) {
            if($staff){
                $data['staff_id'] = $staff->id;
                $staffDocument = StaffDocuments::create($data);
                if($staffDocument){
                    return Response()->json([
                        'status' => true,
                        'message' => 'Document added successfully.',
                        'id' => $id
                    ]);
                }
                else {
                    return Response()->json([
                        'status' => false,
                        'message' => 'Document could not be saved. Please try again.'
                    ], 400);
                }
            }
            else {
                return Response()->json([
                    'status' => false,
                    'message' => 'User not found.'
                ], 400);
            }   
        }   else {
            return Response()->json([
                'status' => false,
                'message' => current(current($validator->errors()->getMessages()))
            ], 400);
        }
    }

	function deleteDocument(Request $request, $staffId, $id, $index)
    {
        if(!Permissions::hasPermission('colours', 'delete'))
        {
            $request->session()->flash('error', 'Permission denied.');
            return redirect()->route('admin.dashboard');
		}
		$staffDoc = StaffDocuments::find($id);
		if($staffDoc){
				$fileArray = json_decode($staffDoc->file, true);
				if (count($fileArray) === 1 && array_key_exists($index, $fileArray)) {
					$staffDoc->delete();
					$filePath = public_path($fileArray[$index]);
					if (File::exists($filePath)) {
						File::delete($filePath);
					}
					$request->session()->flash('success', 'Document and row deleted successfully.');
					return redirect()->route('admin.colours.view', ['id' => $staffId]);
				} elseif (array_key_exists($index, $fileArray)) {
					$filePath = public_path($fileArray[$index]);
					if (File::exists($filePath)) {
						File::delete($filePath);
					}
					unset($fileArray[$index]);
					$staffDoc->file = json_encode(array_values($fileArray));
					$staffDoc->save();
					$request->session()->flash('success', 'Document deleted successfully.');
					return redirect()->route('admin.colours.view', ['id' => $staffId]);
				} else {
					$request->session()->flash('error', 'Invalid index specified.');
					return redirect()->route('admin.colours.view', ['id' => $staffId]);
				}
			}
			else {
				$request->session()->flash('Document not found.');
				return redirect()->route('admin.colours.view',['id' => $staffId]);
		}
    }
}

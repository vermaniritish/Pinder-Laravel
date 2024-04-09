<?php

/**
 * Newsletters Class
 *
 * @package    NewslettersController
 * @copyright  2023
 * @author     Irfan Ahmad <irfanahmed1555@gmail.com>
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;

use App\Models\Admin\Permissions;
use App\Models\Admin\Newsletter;
use App\Models\Admin\Admins;

use App\Http\Controllers\Admin\AppController;

class NewsletterController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('newsletters', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(newsletter.email LIKE ? )'] = [$search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    		{
    			$where['newsletter.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		}

    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    		{
    			$where['newsletter.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    		}
    	}

    	if($request->get('admins'))
    	{
    		$admins = $request->get('admins');
    		$admins = $admins ? implode(',', $admins) : 0;
    		$where[] = 'newsletter.created_by IN ('.$admins.')';
    	}

    	if($request->get('status'))
    	{
    		switch($request->get('status'))
    		{
    			case 'active':
    				$where['newsletter.status'] = 1;
    			break;
    			case 'non_active':
    				$where['newsletter.status'] = 0;
    			break;
    		}    		
    	}

    	$listing = Newsletter::getListing($request, $where);

    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/newsletter/listingLoop", 
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
	    		"admin/newsletter/index", 
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
		$adminIds = Newsletter::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
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
    	if(!Permissions::hasPermission('newsletters', 'create'))
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
	                'email' => 'required'
	                
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$newsletter = Newsletter::create($data);
	        	if($newsletter)
	        	{
	        		$request->session()->flash('success', 'Newsletter created successfully.');
	        		return redirect()->route('admin.newsletter');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Newsletter could not be save. Please try again.');
		    		return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}

	    return view("admin/newsletter/add", [
	    		]);
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('newsletters', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$newsletter = Newsletter::get($id);
    	if($newsletter)
    	{
	    	return view("admin/newsletter/view", [
    			'page' => $newsletter
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function edit(Request $request, $id)
    {
    	if(!Permissions::hasPermission('newsletters', 'update'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$newsletter = Newsletter::get($id);

    	if($newsletter)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
	    		$validator = Validator::make(
		            $request->toArray(),
		            [
		                'email' => [
		                	'required'
		                ],		                
		            ]
		        );

		        if(!$validator->fails())
		        {
		        	unset($data['_token']);

		        	if(Newsletter::modify($id, $data))
		        	{
		        		$request->session()->flash('success', 'Newsletter updated successfully.');
		        		return redirect()->route('admin.newsletter');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Newsletter could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			return view("admin/newsletter/edit", [
    			'page' => $newsletter
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('newsletter', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = Newsletter::find($id);
    	if($admin->delete())
    	{
    		$request->session()->flash('success', 'Newsletter deleted successfully.');
    		return redirect()->route('admin.newsletter');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Newsletter could not be delete.');
    		return redirect()->route('admin.newsletter');
    	}
    }

    function bulkActions(Request $request, $action)
    {
    	if( ($action != 'delete' && !Permissions::hasPermission('newsletter', 'update')) || ($action == 'delete' && !Permissions::hasPermission('newsletter', 'delete')) )
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$ids = $request->get('ids');
    	if(is_array($ids) && !empty($ids))
    	{
    		switch($action)
    		{
    			case 'active':
    				Newsletter::modifyAll($ids, [
    					'status' => 1
    				]);
    				$message = count($ids) . ' records has been published.';
    			break;
    			case 'inactive':
    				Newsletter::modifyAll($ids, [
    					'status' => 0
    				]);
    				$message = count($ids) . ' records has been unpublished.';
    			break;
    			case 'delete':
    				Newsletter::removeAll($ids);
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

    function export()
    {
         $headers = array(
            "Content-type"        => "text/csv",
            "Content-Disposition" => "attachment; filename=subscribers.csv",
            "Pragma"              => "no-cache",
            "Cache-Control"       => "must-revalidate, post-check=0, pre-check=0",
            "Expires"             => "0"
        );

        $listing = Newsletter::getAll();

        $callback = function() use($listing){
            $file = fopen('php://output', 'w');
            fputcsv($file, ['Email', 'Subscribed on']);

            foreach($listing as $l)
            {
                fputcsv($file, array( $l['email'], date('m/d/Y', strtotime($l['created'])) ));
            }

            fclose($file);
        };

        return Response()->stream($callback, 200, $headers);
    }
}

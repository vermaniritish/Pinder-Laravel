<?php
/**
 * Activities Class
 *
 * @package    ActivitiesController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Settings;
use App\Models\Admin\Blogs;
use App\Models\Admin\Permissions;
use App\Models\Admin\AdminAuth;
use App\Models\Admin\Admins;
use App\Models\Admin\Users;
use App\Libraries\General;
use App\Libraries\FileSystem;
use App\Models\Admin\Activities;
use App\Models\Admin\EmailLogs;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class ActivitiesController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function logs(Request $request)
    {
    	if(!AdminAuth::isAdmin())
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(activities.url LIKE ? or users.first_name LIKE ? or users.last_name LIKE ? or admins.first_name LIKE ? or admins.last_name LIKE ? or activities.ip LIKE ?)'] = [$search, $search, $search, $search, $search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['activities.created >= ?'] = [
    				date('Y-m-d', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['activities.created <= ?'] = [
    				date('Y-m-d', strtotime($createdOn[1]))
    			];
    	}

    	if($request->get('admins'))
    	{
    		$admins = $request->get('admins');
    		$admins = $admins ? implode(',', $admins) : 0;
    		$where[] = 'activities.admin IN ('.$admins.')';
    	}
    	
    	if($request->get('users'))
    	{
    		$users = $request->get('users');
    		$users = $users ? implode(',', $users) : 0;
    		$where[] = 'activities.client IN ('.$users.')';
    	}

    	if($request->get('role'))
    	{
    		$role = $request->get('role');
    		switch ($role) {
    			case 'admin':
    				$where[] = 'activities.admin is not null';
    			break;
    			case 'client':
    				$where[] = 'activities.client is not null';
    			break;
    		}
    	}

    	$listing = Activities::getListing($request, $where);


    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/activities/logs/listingLoop", 
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
			/** Filter Data **/
			$admins = Admins::getAll(
	    		[
	    			'admins.id',
	    			'admins.first_name',
	    			'admins.last_name'
	    		],
	    		[
	    			'admins.status' => 1
	    		],
	    		'concat(admins.first_name, admins.last_name) desc'
	    	);

	    	$users = Users::getAll(
	    		[
	    			'users.id',
	    			'users.first_name',
	    			'users.last_name'
	    		],
	    		[
	    			'users.status' => 1
	    		],
	    		'concat(users.first_name, users.last_name) desc'
	    	);
	    	/** Filter Data **/
	    	return view(
	    		"admin/activities/logs/index",
	    		[
	    			'listing' => $listing,
	    			'admins' => $admins,
	    			'users' => $users 
	    		]
	    	);
	    }
    }

    function logView(Request $request, $id)
    {
        if(!AdminAuth::isAdmin())
        {
            $request->session()->flash('error', 'Permission denied.');
            return redirect()->route('admin.dashboard');
        }

        $log = Activities::get($id);
        if($log)
        {
            return view("admin/activities/logs/view", [
                'log' => $log
            ]);
        }
        else
        {
            abort(404);
        }
    }

    function bulkActions(Request $request, $action)
    {
        if(!AdminAuth::isAdmin()) 
        {
            $request->session()->flash('error', 'Permission denied.');
            return redirect()->route('admin.dashboard');
        }

        $ids = $request->get('ids');
        if(is_array($ids) && !empty($ids))
        {
            switch ($action) {
                
                case 'delete':
                    Activities::removeAll($ids);
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

    function emails(Request $request)
    {
    	if(!AdminAuth::isAdmin())
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(email_logs.subject LIKE ? or email_logs.description LIKE ? or email_logs.from LIKE ? or email_logs.to LIKE ? or email_logs.cc LIKE ? or email_logs.bcc LIKE ?)'] = [$search, $search, $search, $search, $search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['email_logs.created >= ?'] = [
    				date('Y-m-d', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['email_logs.created <= ?'] = [
    				date('Y-m-d', strtotime($createdOn[1]))
    			];
    	}

    	$listing = EmailLogs::getListing($request, $where);

    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/activities/emails/listingLoop", 
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
	    	return view(
	    		"admin/activities/emails/index",
	    		[
	    			'listing' => $listing
	    		]
	    	);
	    }
    }

    function emailView(Request $request, $id)
    {
        if(!AdminAuth::isAdmin())
        {
            $request->session()->flash('error', 'Permission denied.');
            return redirect()->route('admin.dashboard');
        }

        $log = EmailLogs::find($id);
        if($log)
        {
            return view("admin/activities/emails/view", [
                'log' => $log
            ]);
        }
        else
        {
            abort(404);
        }
    }
}
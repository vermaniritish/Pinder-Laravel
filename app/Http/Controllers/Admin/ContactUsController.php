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
use App\Models\Admin\Permissions;
use App\Models\Admin\Admins;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\ContactUs;

class ContactUsController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}


    function index(Request $request)
    {
    	if(!Permissions::hasPermission('contact_us', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(contact_us.title LIKE ? )'] = [$search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['contact_us.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['contact_us.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    	}

    	$listing = ContactUs::getListing($request, $where);


    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/contactUs/listingLoop", 
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
	    		"admin/contactUs/index", 
	    		[
	    			'listing' => $listing
	    		]
	    	);
	    }
    }

    function filters(Request $request)
    {

    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('contact_us', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = ContactUs::find($id);
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

	function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('contact_us', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$page = ContactUs::get($id);
    	if($page)
    	{
	    	return view("admin/contactUs/view", [
    			'page' => $page
    		]);
		}
		else
		{
			abort(404);
		}
    }
}

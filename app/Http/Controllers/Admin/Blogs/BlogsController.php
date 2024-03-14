<?php

/**
 * Blogs Class
 *
 * @package    BlogsController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin\Blogs;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Settings;
use App\Models\Admin\Permissions;
use App\Models\Admin\AdminAuth;
use App\Libraries\General;
use App\Models\Admin\Blogs;
use App\Models\Admin\BlogCategories;
use App\Models\Admin\Admins;
use App\Models\Admin\BlogCategoryRelation;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;
use App\Libraries\FileSystem;
use App\Http\Controllers\Admin\AppController;

class BlogsController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('blogs', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(blogs.title LIKE ? or owner.first_name LIKE ? or owner.last_name LIKE ?)'] = [$search, $search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['blogs.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['blogs.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    	}

    	if($request->get('admins'))
    	{
    		$admins = $request->get('admins');
    		$admins = $admins ? implode(',', $admins) : 0;
    		$where[] = 'blogs.created_by IN ('.$admins.')';
    	}

    	if($request->get('category'))
    	{
    		$blogIds = BlogCategoryRelation::distinct()->whereIn('category_id', $request->get('category'))->pluck('blog_id')->toArray();
    		$blogIds = !empty($blogIds) ? implode(',', $blogIds) : '0';
    		$where[] = 'blogs.id IN ('.$blogIds.')';
    	}

    	if($request->get('status') !== "" && $request->get('status') !== null)
    	{    		
    		$where['blogs.status'] = $request->get('status');
    	}
    	
    	$listing = Blogs::getListing($request, $where);


    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/blogs/listingLoop", 
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
			$filters = $this->filters($request);
	    	/** Filter Data **/
	    	return view(
	    		"admin/blogs/index", 
	    		[
	    			'listing' => $listing,
	    			'categories' => $filters['categories'],
	    			'admins' => $filters['admins']
	    		]
	    	);
	    }
    }

    function filters(Request $request)
    {
    	$catIds = BlogCategoryRelation::distinct()->pluck('category_id')->toArray();
    	$categories = [];
    	if($catIds)
    	{
			$categories = BlogCategories::getAllCategorySubCategory($catIds);
		}

		$admins = [];
		$adminIds = Blogs::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
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
    		'categories' => $categories,
	    	'admins' => $admins
    	];
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('blogs', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$blog = Blogs::get($id);
    	if($blog)
    	{
	    	return view("admin/blogs/view", [
    			'blog' => $blog
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function add(Request $request)
    {
    	if(!Permissions::hasPermission('blogs', 'create'))
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
	                'title' => 'required|unique:blogs,title',
	                'description' => 'required',
	                'category' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$categories = [];
	        	if(isset($data['category']) && $data['category']) {
	        		$categories = $data['category'];
	        	}
	        	unset($data['category']);
	        	
	        	$blog = Blogs::create($data);
	        	if($blog)
	        	{
	        		if(!empty($categories))
	        		{
	        			Blogs::handleCategories($blog->id, $categories);
	        		}

	        		$request->session()->flash('success', 'Blog created successfully.');
	        		return redirect()->route('admin.blogs');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Blog could not be save. Please try again.');
		    		return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}
	    
	    $categories = BlogCategories::getAllCategorySubCategory();

	    return view("admin/blogs/add", [
	    			'categories' => $categories
	    		]);
    }

    function edit(Request $request, $id)
    {
    	if(!Permissions::hasPermission('blogs', 'update'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$blog = Blogs::get($id);
    	if($blog)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
	    		$validator = Validator::make(
		            $request->toArray(),
		            [
		                'title' => [
		                	'required',
		                	Rule::unique('blogs')->ignore($blog->id)
		                ],
		                'description' => 'required'
		            ]
		        );

		        if(!$validator->fails())
		        {
		        	unset($data['_token']);
	        		
	        		/** ONLY IN CASE OF MULTIPLE IMAGE USE THIS **/
	        		/*if(isset($data['image']) && $data['image'])
	        		{
	        			$data['image'] = json_decode($data['image'], true);
	        			$blog->image = $blog->image ? json_decode($blog->image) : [];
		        		$data['image'] = array_merge($blog->image, $data['image']);
		        		$data['image'] = json_encode($data['image']);
		        	}
		        	else
		        	{
		        		unset($data['image']);
		        	}*/
		        	/** ONLY IN CASE OF MULTIPLE IMAGE USE THIS **/

		        	/** IN CASE OF SINGLE UPLOAD **/
		        	if(isset($data['image']) && $data['image'])
		        	{
		        		$oldImage = $blog->image;
		        	}
		        	else
		        	{
		        		unset($data['image']);
		        		
		        	}
		        	/** IN CASE OF SINGLE UPLOAD **/

		        	$categories = [];
		        	if(isset($data['category']) && $data['category']) {
		        		$categories = $data['category'];
		        	}
		        	unset($data['category']);

		        	if(Blogs::modify($id, $data))
		        	{
		        		/** IN CASE OF SINGLE UPLOAD **/
		        		if(isset($oldImage) && $oldImage)
		        		{
		        			FileSystem::deleteFile($oldImage);
		        		}
		        		/** IN CASE OF SINGLE UPLOAD **/

		        		if(!empty($categories))
		        		{
		        			Blogs::handleCategories($blog->id, $categories);
		        		}

		        		$request->session()->flash('success', 'Blog updated successfully.');
		        		return redirect()->route('admin.blogs');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Blog could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			$categories = BlogCategories::getAllCategorySubCategory();

			return view("admin/blogs/edit", [
    			'blog' => $blog,
    			'categories' => $categories
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('blogs', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$blog = Blogs::find($id);
    	if($blog->delete())
    	{
    		$request->session()->flash('success', 'Blog deleted successfully.');
    		return redirect()->route('admin.blogs');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Blog could not be delete.');
    		return redirect()->route('admin.blogs');
    	}
    }

    function bulkActions(Request $request, $action)
    {
    	if( ($action != 'delete' && !Permissions::hasPermission('blogs', 'update')) || ($action == 'delete' && !Permissions::hasPermission('blogs', 'delete')) ) 
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$ids = $request->get('ids');
    	if(is_array($ids) && !empty($ids))
    	{
    		switch ($action) {
    			case 'active':
    				Blogs::modifyAll($ids, [
    					'status' => 1
    				]);
    				$message = count($ids) . ' records has been published.';
    			break;
    			case 'inactive':
    				Blogs::modifyAll($ids, [
    					'status' => 0
    				]);
    				$message = count($ids) . ' records has been unpublished.';
    			break;
    			case 'delete':
    				Blogs::removeAll($ids);
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

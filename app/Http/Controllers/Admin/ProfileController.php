<?php

/**
 * Profile Class
 *
 * @package    ProfileController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use App\Libraries\General;
use App\Models\Admin\Admins;
use App\Models\Admin\AdminAuth;
use App\Models\Admin\Permissions;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Hash;
use App\Libraries\FileSystem;

class ProfileController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
		$id = AdminAuth::getLoginId();

    	$admin = Admins::get($id);
    	if($admin)
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
		                	Rule::unique('admins')->ignore($admin->id),
		                ]
		            ]
		        );

		        if(!$validator->fails())
		        {
		        	unset($data['_token']);

		        	$admin = Admins::modify($id, $data);
		        	if($admin)
		        	{
		        		$request->session()->flash('success', 'Profile updated successfully.');
		        		redirect()->route('admin.profile');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Profile could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			return view("admin/profile/index", [
				'adminPermissions' => Permissions::getUserPermissions($admin->id),
    			'permissions' => Permissions::all(),
    			'admin' => $admin
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function changePassword(Request $request)
    {
		$id = AdminAuth::getLoginId();

    	$admin = Admins::find($id);
    	if($admin)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();

	            $validator = Validator::make(
		            $request->toArray(),
		            [
		                'password' => [
						    'min:8'
		                ],
		                'new_password' => [
						    'min:8'
		                ],
		                'confirm_password' => [
						    'min:8'
		                ]
		            ]
		        );

		        if(!$validator->fails())
		        {
		        	unset($data['_token']);
		        	if(Hash::check($data['old_password'], $admin->password))
		        	{
		        		if($data['new_password'] && $data['confirm_password'] && $data['new_password'] == $data['confirm_password'])
		        		{
		        			$admin->password = $data['new_password'];

		        			if($admin->save())
		        			{
		        				$request->session()->flash('success', 'Password updated successfully.');
			    				return redirect()->route('admin.changePassword');
		        			}
		        			else
		        			{
		        				$request->session()->flash('error', 'New password could be updated.');
			    				return redirect()->back()->withErrors($validator)->withInput();				
		        			}
		        		}
		        		else
		        		{
		        			$request->session()->flash('error', 'New password did not match.');
			    			return redirect()->back()->withErrors($validator)->withInput();		
		        		}
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Old password is wrong.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			return view("admin/profile/changePassword", [
    			'admin' => $admin
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function updatePicture(Request $request)
    {
    	if($request->isMethod('post'))
    	{
    		$data = $request->toArray();

            $validator = Validator::make(
	            $request->toArray(),
	            [
	                'file' => 'mimes:jpg,jpeg,png,gif',
	            ]
	        );

	        if(!$validator->fails())
	        {
				if(isset($data) && $data['id'])
					$id = $data['id'];
				else
					$id = AdminAuth::getLoginId();

		    	$admin = Admins::find($id);
		    	if($admin)
		    	{
		    		$oldImage = $admin->image;
		    		if($request->file('file')->isValid())
		    		{
		    			$file = FileSystem::uploadImage(
		    				$request->file('file'),
		    				'admins'
		    			);

		    			if($file)
		    			{
		    				$admin->image = $file;
		    				if($admin->save())
		    				{
		    					$originalName = FileSystem::getFileNameFromPath($file);
		    					
		    					FileSystem::resizeImage($file, 'M-' . $originalName, "350*350");
		    					FileSystem::resizeImage($file, 'S-' . $originalName, "100*100");
		    					$picture = $admin->getResizeImagesAttribute()['medium'];

		    					if($oldImage)
		    					{
		    						FileSystem::deleteFile($oldImage);
		    					}

		    					
		    					return Response()->json([
							    	'status' => 'success',
							    	'message' => 'Picture uploaded successfully.',
							    	'picture' => url($picture)
							    ]);		
		    				}
		    				else
		    				{
		    					FileSystem::deleteFile($file);
		    					return Response()->json([
							    	'status' => 'error',
							    	'message' => 'Picture could not be uploaded.'
							    ]);	
		    				}
		    				
		    			}
		    			else
		    			{
		    				return Response()->json([
						    	'status' => 'error',
						    	'message' => 'Picture could not be upload.'
						    ]);		
		    			}
		    		}
					else
					{
						return Response()->json([
					    	'status' => 'error',
					    	'message' => 'Picture could not be uploaded. Please try again.'
					    ]);
					}
				}
				else
				{
					return Response()->json([
				    	'status' => 'error',
				    	'message' => 'Admin member is missing.'
				    ]);
				}
			}
		}
		else
		{
			return Response()->json([
			    	'status' => 'error',
			    	'message' => 'Admin member is missing.'
			    ]);
		}
    }
}

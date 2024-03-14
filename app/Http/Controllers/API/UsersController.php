<?php
/**
 * Users Class
 *
 * @package    UsersController
 
 
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
use App\Models\API\Users;
use App\Models\API\Shops;
use App\Models\API\Products;
use App\Models\API\ApiAuth;
use App\Models\API\UsersWishlist;
use Illuminate\Support\Facades\Hash;
use App\Libraries\FileSystem;

class UsersController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function profile(Request $request)
	{
		$user = Users::select([
				'id',
				'first_name',
				'last_name',
				'email',
				'phonenumber',
				'image',
				'facebook_id',
				'google_id',
				'google_email',
				'created',
			])
			->where('id', ApiAuth::getLoginId())
			->first();
		if($user)
		{
			$user->permissions = Users::getPermissions($user->id);
			return Response()->json([
		    	'status' => true,
	    		'user' => $user
		    ]);
		}
		else
		{
			return Response()->json([
		    	'status' => false
		    ], 403);
		}
	}


	function updateProfile(Request $request)
	{

		$allowed = ['first_name', 'last_name', 'permissions'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	            	'first_name' => 'required',
	            	'permissions' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();
	        	if($user = Users::find($userId))
	        	{
		        	$data = [
		        		'first_name' => $request->get('first_name'),
		        		'last_name' => $request->get('last_name')
		        	];

		        	if($user = Users::modify($userId, $data))
		        	{
		        		if(!empty($request->get('permissions')))
		        		{
		        			Users::handlePermissions($userId, $request->get('permissions'));
		        		}

	    				$user = ApiAuth::getLoginUser();
	    				if($user)
	    				{
	    					$user->wishlist = UsersWishlist::where('user_id', $user->id)->pluck('product_id')->toArray();
	    					
	    					return Response()->json([
						    	'status' => true,
						    	'message' => 'Profile Updated',
						    	'user' => $user
						    ]);
	    				}
	    				else
	    				{
	    					return Response()->json([
						    	'status' => false,
						    	'message' => 'Unable to update profile. Please try again.'
						    ], 400);
	    				}
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Unable to update profile. Please try again.'
					    ], 400);
		        	}
		        }
		        else
		        {
		        	return Response()->json([
				    	'status' => false
				    ], 403);
		        }
		    }
		    else
		    {
		    	return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		    }
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Some of inputs are invalid in request.',
		    ], 400);
	    }
	}

	function updateEmail(Request $request)
	{
		$allowed = ['email', 'password'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	            	'email' => 'required',
	            	'password' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();
	        	if($user = Users::find($userId))
	        	{
	        		if(Hash::check($request->get('password'), $user->password))
	        		{
	        			$user->token = General::hash(64);
	        			if($user->save())
	        			{
		        			$newEmail = $request->get('email');
		        			$link = Settings::get('website_url') . '/email-verification/' . $user->token . '/' . General::encrypt($newEmail);
		        			$codes = [
		        				'{first_name}' => $user->first_name,
		        				'{last_name}' => $user->last_name,
		        				'{email_update_link}' => General::urlToAnchor($link)
		        			];

		        			General::sendTemplateEmail($newEmail, 'email-update', $codes);

	    					return Response()->json([
						    	'status' => true,
						    	'message' => 'Link sent to your enter email address. Please click on link in email to update.',
						    	'user' => $user
						    ]);
	    				}
	    				else
	    				{
	    					return Response()->json([
						    	'status' => false,
						    	'message' => 'Link could not be generate. Please try again.'
						    ], 400);
	    				}
			        }
			        else
			        {
			        	return Response()->json([
					    	'status' => false,
					    	'message' => 'Your password is incorrect.'
					    ], 400);
			        }
		        }
		        else
		        {
		        	return Response()->json([
				    	'status' => false
				    ], 403);
		        }
		    }
		    else
		    {
		    	return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		    }
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Some of inputs are invalid in request.',
		    ], 400);
	    }
	}

	function updateSocial(Request $request)
	{

		$allowed = ['social_id', 'social_type'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	            	'social_id' => 'required',
	            	'social_type' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();
	        	if($user = Users::find($userId))
	        	{
	        		if($request->get('social_type') == 'facebook')
	        		{
	        			$data = [
			        		'facebook_id' => $request->get('social_id')
			        	];
	        		}
	        		elseif($request->get('social_type') == 'google')
	        		{
	        			$data = [
			        		'google_id' => $request->get('social_id'),
			        		'google_email' => $request->get('social_email') ? $request->get('social_email') : null,
			        	];	
	        		}
	        		else
	        		{
	        			return Response()->json([
					    	'status' => false,
					    	'message' => 'Invalid social.'
					    ], 400);
	        		}
		        	
		        	if($user = Users::modify($userId, $data))
		        	{
		        		$user = ApiAuth::getLoginUser();
	    				if($user)
	    				{
	    					return Response()->json([
						    	'status' => true,
						    	'message' => 'Account linked.',
						    	'user' => $user
						    ]);
	    				}
	    				else
	    				{
	    					return Response()->json([
						    	'status' => false,
						    	'message' => 'Unable to update profile. Please try again.'
						    ], 400);
	    				}
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Unable to update profile. Please try again.'
					    ], 400);
		        	}
		        }
		        else
		        {
		        	return Response()->json([
				    	'status' => false
				    ], 403);
		        }
		    }
		    else
		    {
		    	return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		    }
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Some of inputs are invalid in request.',
		    ], 400);
	    }
	}

	function unlinkSocial(Request $request)
	{

		$allowed = ['social_type'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	            	'social_type' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();
	        	if($user = Users::find($userId))
	        	{
	        		if($request->get('social_type') == 'facebook')
	        		{
	        			$user->facebook_id = null;
	        		}
	        		elseif($request->get('social_type') == 'google')
	        		{
	        			$user->google_id = null;
	        			$user->google_email = null;
	        		}
	        		else
	        		{
	        			return Response()->json([
					    	'status' => false,
					    	'message' => 'Invalid social.'
					    ], 400);
	        		}
		        	
		        	if($user->save())
		        	{
		        		$user = ApiAuth::getLoginUser();
	    				if($user)
	    				{
	    					return Response()->json([
						    	'status' => true,
						    	'message' => 'Account unlinked.',
						    	'user' => $user
						    ]);
	    				}
	    				else
	    				{
	    					return Response()->json([
						    	'status' => false,
						    	'message' => 'Unable to update profile. Please try again.'
						    ], 400);
	    				}
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Unable to update profile. Please try again.'
					    ], 400);
		        	}
		        }
		        else
		        {
		        	return Response()->json([
				    	'status' => false
				    ], 403);
		        }
		    }
		    else
		    {
		    	return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		    }
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Some of inputs are invalid in request.',
		    ], 400);
	    }
	}

	function changePassword(Request $request)
	{
		$allowed = ['old_password', 'new_password'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'old_password' => [
					    'min:8'
	                ],
	                'new_password' => [
					    'min:8'
	                ]
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();
	        	if($user = Users::find($userId))
	        	{
	        		$data = $request->toArray();

	        		if(Hash::check($data['old_password'], $user->password))
		        	{
		        		$user->password = $data['new_password'];

	        			if($user->save())
	        			{
	        				return Response()->json([
						    	'status' => true,
						    	'message' => 'Password updated successfully.'
						    ]);
	        			}
	        			else
	        			{
		    				return Response()->json([
						    	'status' => false,
						    	'message' => 'New password could be updated.'
						    ], 400);
	        			}
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Your current password is incorrect.'
					    ], 400);
		        	}
		        }
		        else
		        {
		        	return Response()->json([
				    	'status' => false
				    ], 403);
		        }
		    }
		    else
		    {
		    	return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		    }
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Some of inputs are invalid in request.',
		    ], 400);
	    }
	}

	function uploadPicture(Request $request)
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
				$id = ApiAuth::getLoginId();

		    	$user = Users::find($id);
		    	if($user)
		    	{
		    		$oldImage = $user->image;
		    		if($request->file('file')->isValid())
		    		{
		    			$file = FileSystem::uploadImage(
		    				$request->file('file'),
		    				'users'
		    			);

		    			if($file)
		    			{
		    				$user->image = $file;
		    				if($user->save())
		    				{
		    					$originalName = FileSystem::getFileNameFromPath($file);
		    					
		    					FileSystem::resizeImage($file, 'M-' . $originalName, "350*350");
		    					FileSystem::resizeImage($file, 'S-' . $originalName, "100*100");
		    					$picture = $user->image['medium'];

		    					if($oldImage && isset($oldImage['original']) && $oldImage['original'])
		    					{
		    						FileSystem::deleteFile($oldImage['original']);
		    					}

		    					
		    					return Response()->json([
							    	'status' => true,
							    	'message' => 'Picture uploaded successfully.',
							    	'picture' => url($picture),
							    	'user' => ApiAuth::getLoginUser()
							    ]);		
		    				}
		    				else
		    				{
		    					FileSystem::deleteFile($file);
		    					return Response()->json([
							    	'status' => false,
							    	'message' => 'Picture could not be uploaded.'
							    ], 400);	
		    				}
		    				
		    			}
		    			else
		    			{
		    				return Response()->json([
						    	'status' => false,
						    	'message' => 'Picture could not be upload.'
						    ], 400);		
		    			}
		    		}
					else
					{
						return Response()->json([
					    	'status' => false,
					    	'message' => 'Picture could not be uploaded. Please try again.'
					    ], 400);
					}
				}
				else
				{
					return Response()->json([
				    	'status' => false,
				    ], 401);
				}
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => 'Admin member is missing.'
			    ], 400);
		}
	}

	function deleteAccount(Request $request)
	{
		$id = ApiAuth::getLoginId();
		$user = Users::find($id);
		if($user)
		{
			if($user->delete())
			{
				Shops::where('user_id', $user->id)->delete();
				Products::where('user_id', $user->id)->delete();
				
				return Response()->json([
			    	'status' => true,
			    ]);
			}
			else
			{
				return Response()->json([
			    	'status' => false,
			    	'message' => 'You account could not deleted. Please try again.'
			    ], 400);
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => 'Something went wrong.'
			    ], 400);
		}
	}

	function listOrders(){
		
	}
}
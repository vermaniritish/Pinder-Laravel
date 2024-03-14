<?php
/**
 * Messages Class
 *
 * @package    MessagesController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\Admin\Settings;
use App\Models\API\ApiAuth;
use App\Models\API\Messages;
use App\Models\API\UsersMatches;
use App\Models\API\Products;
use App\Libraries\General;
use App\Libraries\FileSystem;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Arr;

class MessagesController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function friends(Request $request)
	{
		$userId = ApiAuth::getLoginId();
		
		$friends = UsersMatches::getListing($request, [
			'users_matches.user_id' => $userId
		], 20);

		$sellers = $buyers = $listing = [];
		foreach($friends->items() as $k => $v)
		{
			$v = $v->toArray();
			$v['product']['id'] = $v['product_id'];
            $v['product']['title'] = $v['product_title'];
            $v['product']['slug'] = $v['product_slug'];
            $v['product']['image'] = $v['product_image'] ? FileSystem::getAllSizeImages($v['product_image']) : [];
            $v['product']['user_id'] = $v['product_user_id'];
            $v['product']['deleted_at'] = $v['deleted_at'];
            $v['matches']['id'] = $v['match_id'];
            $v['matches']['first_name'] = $v['match_first_name'];
            $v['matches']['last_name'] = $v['match_last_name'];
            $v['matches']['image'] = $v['match_image'] ? FileSystem::getAllSizeImages($v['match_image']) : null;

			$v['count'] = Messages::select(['id'])
				->where('product_id', $v['product_id'])
				->where('from_id', $v['match_id'])
				->where('to_id', $userId)
				->where('read', 0)
				->groupBy(['from_id', 'product_id'])
				->count();

			$listing[] = $v;

			if($v['product'] && $v['product']['user_id'] == $userId)
			{
				$respond = DB::select('SELECT AVG(TIMESTAMPDIFF(MINUTE, created, read_at)) as response_seconds from messages where to_id = '.$v['matches']['id']	.' and read_at is not null;');
				$v['respond'] = $respond && $respond[0] && $respond[0]->response_seconds ? $respond[0]->response_seconds : null;
				$buyers[] = $v;
			}
			else
			{
				$respond = DB::select('SELECT AVG(TIMESTAMPDIFF(MINUTE, created, read_at)) as response_seconds from messages where to_id = '.$v['product']['user_id']	.' and read_at is not null;');
				$v['respond'] = $respond && $respond[0] && $respond[0]->response_seconds ? $respond[0]->response_seconds : null;
				$sellers[] = $v;
			}

		}

		$friendIds = UsersMatches::where('users_matches.user_id', $userId)
			->leftJoin('users', 'users.id', '=', 'users_matches.match_id')
			->where('users_matches.is_delete', 0)
            ->where('users.status', 1)
			->pluck('match_id')
			->toArray();
		
		$totalCounts = Messages::getUnreadCounts($userId);
		$buyerCounts = Messages::getBuyerCounts($userId);
		$sellerCounts = Messages::getSellerCounts($userId);

		return Response()->json([
	    	'status' => true,
	    	'friends' => $listing,
	    	'buyers' => $buyers,
	    	'sellers' => $sellers,
	    	'friendIds' => $friendIds,
	    	'totalCounts' => $totalCounts,
	    	'buyerCounts' => $buyerCounts,
	    	'sellerCounts' => $sellerCounts
	    ]);
	}

	function listing(Request $request, $toId, $productId)
	{
		$userId = ApiAuth::getLoginId();

		$match = UsersMatches::get($userId, $toId, $productId);
		if($match)
		{
			/** Make all messages as read for other user **/
			$this->makeReadForOther($toId, $productId);
			/** Make all messages as read for other user **/

			$messages = Messages::getListing($request, [
				'((from_id  = ? and to_id = ?) or (from_id  = ? and to_id = ?))' => [$userId, $toId, $toId, $userId],
				'product_id' => $productId,
				'(messages.id > ?)' => [$match->last_delete_id ? $match->last_delete_id : 0]
			]);

			$listing = [];
			foreach ($messages as $key => $value) 
			{
				$image = $value->image ? FileSystem::getAllSizeImages($value->image) : null;
				$listing[] = [
					"_id" => $value->id,
					"product_id" => $value->product_id,
	                "text" => $value->message,
	                "createdAt" => (date('Y-m-d', strtotime($value->created)) . 'T' . date('H:i:s', strtotime($value->created))),
	                "sent" => true,
	                "pending" => !$value->read ? true : false,
	                "received" => $value->read ? true : false,
	                'attachment' => $value->media_url ? FileSystem::getAllSizeImages($value->media_url)['small'] : null,
				    'attachment_type' => $value->media_type,
	                "delete_for_me" => $value->delete_for_me,
	                "deleted_for_everyone" => $value->deleted_for_everyone,
	                "user" => [
	                    "_id" => $value->from_id,
	                    "name" => $value->first_name . ' ' . $value->last_name,	
	                    "avatar" => $image && isset($image['small']) && $image['small'] ? $image['small'] : ($image && isset($image['original']) && $image['original'] ? $image['original'] : ""),
	                ]
				];
			}
			$listing = array_reverse($listing);
			$totalCounts = Messages::getUnreadCounts($userId);
			$buyerCounts = Messages::getBuyerCounts($userId);
			$sellerCounts = Messages::getSellerCounts($userId);
			$lastRead = Messages::where('product_id', $productId)
				->where('from_id', $userId)
				->where('to_id', $toId)
				->where('read', 1)
				->orderBy('id', 'desc')
				->pluck('id')
				->first();
			$lastReadOther = Messages::where('product_id', $productId)
				->where('from_id', $toId)
				->where('to_id', $userId)
				->where('read', 1)
				->orderBy('id', 'desc')
				->pluck('id')
				->first();
			return Response()->json([
				'status' => true,
				'listing' => $listing,
				'totalCounts' => $totalCounts,
				'buyerCounts' => $buyerCounts,
		    	'sellerCounts' => $sellerCounts,
		    	'mute' => $match->is_mute,
		    	'lastRead' => $lastRead,
		    	'lastReadOther' => $lastReadOther
			]);
		}
	}

	protected function makeReadForOther($fromId, $productId)
	{
		$userId = ApiAuth::getLoginId();
		return Messages::where('from_id', $fromId)
			->where('to_id', $userId)
			->where('product_id', $productId)
			->where('read', 0)
			->update([
				'read' => 1,
				'read_at' => date('Y-m-d H:i:s')
			]);
	}

	function send(Request $request)
	{
		$allowed = ['to', 'message'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'to' => 'required',
	                'message' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();

	        	$data = $request->toArray();
	        	
	        	$message = Messages::create([
	        		'product_id' => $data['message']['product_id'],
	        		'from_id' => $userId,
	        		'to_id' => $data['to'],
	        		'message' => $data['message']['text'],
	        		'message_id' => $data['message']['_id'],
	        		'media_url' => isset($data['message']['attachment']) && $data['message']['attachment'] ? $data['message']['attachment'] : null,
	        		'media_type' => isset($data['message']['attachment']) && $data['message']['attachment'] ? 'image' : null,
	        		'read' => 0,
	        	]);

	        	if($message)
	        	{
	        		UsersMatches::updateLastMessage($userId, $message->to_id, $message);
	        		
	        		$match = UsersMatches::getByUser($message->to_id, $message->product_id);

	        		// if($match->is_mute)
	        		// {
	        		// 	$message->read = 1;
	        		// 	$message->save();
	        		// }
	        		
	        		//get product wise count
					// $count = Messages::select(['id'])
					// 	->where('product_id', $message->product_id)
					// 	->where('from_id', $userId)
					// 	->where('to_id', $message->to_id)
					// 	->where('read', 0)
					// 	->groupBy(['from_id', 'product_id'])
					// 	->count();

					//get total count
					$totalCounts = Messages::getUnreadCounts($message->to_id);
					// $buyerCounts = Messages::getBuyerCounts($message->to_id);
					// $sellerCounts = Messages::getSellerCounts($message->to_id);

	        		return Response()->json([
				    	'status' => true,
				    	'message' => [
				            '_id' => $message->id,
				            'product_id' => $message->product_id,
				            'msgid' => $message->message_id,
				            'text' => $message->message,
				            'attachment' => $message->media_url ? FileSystem::getAllSizeImages($message->media_url)['small'] : null,
				            'attachment_type' => $message->media_type,
				            'createdAt' => (date('Y-m-d', strtotime($message->created)) . 'T' . date('H:i:s', strtotime($message->created))),
				            'user' => [
				                '_id' => $message->from_id,
				                '_to' => $data['to'],
				                'name' => ApiAuth::getLoginUserName(),
				                'avatar' => ApiAuth::getLoginImage(),
				            ],
				            // 'count' => $count,
				            'totalCounts' => $totalCounts,
				            // 'sellerCounts' => $sellerCounts,
				            'match' => $match
				        ]	
				    ]);
	        	}
	        	else
	        	{
	        		return Response()->json([
				    	'status' => false,
				    	'message' => 'Mesasge could not be saved.'
				    ], 400);
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

	function markRead(Request $request, $id)
	{
    	$userId = ApiAuth::getLoginId();
    	$message = Messages::find($id);
    	if($message && $request->get('read_by') && $request->get('product_id') && $message->to_id == $request->get('read_by') && $message->product_id == $request->get('product_id'))
    	{
			$message->read = 1;
			$message->read_at = date('Y-m-d H:i:s');
	    	if($message->save())
	    	{
	    		$totalCounts = Messages::getUnreadCounts($message->to_id);
				$buyerCounts = Messages::getBuyerCounts($message->to_id);
				$sellerCounts = Messages::getSellerCounts($message->to_id);
	    		return Response()->json([
			    	'status' => true,
			    	'message_id' => $message->id,
			    	'product_id' => $message->product_id,
			    	'from_id' => $message->from_id,
			    	'to_id' => $message->to_id,
			    	'totalCounts' => $totalCounts,
			    	'buyerCounts' => $buyerCounts,
			    	'sellerCounts' => $sellerCounts
			    ]);
	    	}
	    	else
	    	{
	    		return Response()->json([
			    	'status' => false,
			    	'message' => 'Mesasge could not be read.'
			    ], 400);
	    	}
	    }
	    else
	    {
	    	return Response()->json([
			    	'status' => false,
			    	'message' => 'Mesasge could not be read.'
			    ], 400);
	    }
	}

	function getCounts()
	{
		$userId = ApiAuth::getLoginId();

		$counts = Messages::select(['messages.id'])
			->leftJoin('users_matches', function($join) {
                $join->on('messages.to_id', '=', 'users_matches.user_id')
                    ->whereRaw("users_matches.match_id = messages.from_id and users_matches.product_id = messages.product_id")
                    ->limit(1);
            })
			->where('users_matches.is_mute', 0)
			->where('messages.to_id', $userId)
			->where('messages.read', 0)
			->count();
	    return Response()->json([
	    	'status' => true,
	    	'count' => $counts > 0 ? $counts : 0
	    ]);
	}

	function deleteChat(Request $request)
	{
		$allowed = ['to_id', 'product_id'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'to_id' => 'required',
	                'product_id' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();

	        	$data = $request->toArray();
	        	
	        	$match = UsersMatches::get($userId, $data['to_id'], $data['product_id']);
	        	if($match)
	        	{
	        		$match->is_delete = 1;
	        		$match->last_delete_id =  $match->last_message_id;
	        		if($match->save())
	        		{
		        		return Response()->json([
					    	'status' => true,
					    	'message' => 'Chat deleted.'
					    ]);
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Chat could not be delete.'
					    ], 400);		
		        	}
	        	}
	        	else
	        	{
	        		return Response()->json([
				    	'status' => false,
				    	'message' => 'Chat could not be delete.'
				    ], 400);
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

	function muteChat(Request $request)
	{
		$allowed = ['to_id', 'product_id', 'mute'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'to_id' => 'required',
	                'product_id' => 'required',
	                'mute' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();

	        	$data = $request->toArray();
	        	
	        	$match = UsersMatches::get($userId, $data['to_id'], $data['product_id']);
	        	if($match)
	        	{
	        		$match->is_mute = $request->get('mute');
	        		if($match->save())
	        		{
		        		return Response()->json([
					    	'status' => true,
					    	'message' => $match->is_mute ? 'Chat muted.' : 'Chat unmuted.',
					    	'mute' => $match->is_mute
					    ]);
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Chat could not be delete.'
					    ], 400);		
		        	}
	        	}
	        	else
	        	{
	        		return Response()->json([
				    	'status' => false,
				    	'message' => 'Chat could not be delete.'
				    ], 400);
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

	function deleteMessage(Request $request)
	{
		$allowed = ['type', 'message_id'];
    	if($request->has($allowed))
    	{
    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'type' => 'required',
	                'message_id' => 'required'
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$userId = ApiAuth::getLoginId();

	        	$data = $request->toArray();
	        	
	        	$message = Messages::where('id', $request->get('message_id'))->orWhere('message_id', $request->get('message_id'))->first();

	        	if($message && $message->from_id == $userId)
	        	{

	        		$message->delete_for_me = 1;
	        		if($request->get('type') == 'everyone')
	        		{
	        			$message->deleted_for_everyone = 1;
	        		}

	        		if($message->save())
	        		{
	        			if($message->deleted_for_everyone)
	        			{
	        				FileSystem::deleteFile($message->media_url);
	        			}

		        		return Response()->json([
					    	'status' => true,
					    	'message' => 'Message deleted.'
					    ]);
		        	}
		        	else
		        	{
		        		return Response()->json([
					    	'status' => false,
					    	'message' => 'Chat could not be delete.'
					    ], 400);		
		        	}
	        	}
	        	else
	        	{
	        		return Response()->json([
				    	'status' => false,
				    	'message' => 'Message could not be delete.'
				    ], 400);
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

	/**
	* To Upload File
	* @param Request $request
	*/
    function uploadFile(Request $request)
    {
    	$data = $request->toArray();
    	$data['file_type'] = 'image';
    	$validator = Validator::make(
            $request->toArray(),
            [
                'file' => 'required',
            ]
        );

    	if(!$validator->fails())
	    {
	    	if($request->file('file')->isValid())
	    	{
	    		$file = null;
	    		$thumb = null;
	    		if($data['file_type'] == 'image')
	    		{
		    		$file = FileSystem::uploadImage(
	    				$request->file('file'),
	    				'messages'
	    			);

	    			if($file)
	    			{
	    				$originalName = FileSystem::getFileNameFromPath($file);
	    				
	    				FileSystem::resizeImage($file, 'M-' . $originalName, '800*800');
	    				
	    				$thumb = FileSystem::resizeImage($file, 'S-' . $originalName, '300*200');
					}
		    	}
		    	else
		    	{
		    		$file = FileSystem::uploadFile(
	    				$request->file('file'),
	    				'messages'
	    			);
		    	}

    			if($file)
    			{
    				$names = explode('/', $file);
					return Response()->json([
				    	'status' => 'success',
				    	'message' => 'File uploaded successfully.',
				    	'url' => url($file),
				    	'name' => end($names),
				    	'path' => $file,
				    	'thumb' => $thumb
				    ]);
    				
    			}
    			else
    			{
    				return Response()->json([
				    	'status' => 'error',
				    	'message' => 'Sorry, we can only accept images in JPEG and PNG format.'
				    ]);		
    			}
	    	}
	    	else
	    	{
	    		return Response()->json([
		    	'status' => 'error',
		    	'message' => 'File could not be uploaded.'
		    ]);	
	    	}
	   	}
	    else
	    {
	    	return Response()->json([
		    	'status' => 'error',
		    	'message' => 'File could not be uploaded due to missing parameters.'
		    ]);	
	    }
    }

    /**
	* To Remove File
	* @param Request $request
	*/
    function removeFile(Request $request)
    {
    	$data = $request->toArray();

    	$validator = Validator::make(
            $request->toArray(),
            [
                'file' => 'required',
            ]
        );

    	if(!$validator->fails())
	    {
	    	$path = explode('/', $data['file']);
	    	$file = end($path);
	    	$exist = Messages::select(['id'])->whereRaw('media_url LIKE ?', ["%{$file}%"])->first();
	    	if(!$exist)
	    	{
		    	$deleted = FileSystem::deleteFile('/uploads/messages/'. $file);
		    	if($deleted)
	    		{
	    			return Response()->json([
				    	'status' => 'success',
				    	'message' => 'File deleted successfully.'
				    ]);
	    		}
	    		else
	    		{
		    		return Response()->json([
				    	'status' => false,
				    	'message' => 'File could not be deleted.'
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
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'File parameter is missing.'
		    ], 400);
	    }
    }
}
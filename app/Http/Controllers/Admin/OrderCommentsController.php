<?php
namespace App\Http\Controllers\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Permissions;
use App\Models\Admin\AdminAuth;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\OrderComments;
use App\Models\Admin\DiaryPages;
use App\Models\Admin\Orders;

class OrderCommentsController extends AppController
{
    function __construct()
	{
		parent::__construct();
	}

    function index(Request $request, $id)
    {
    	$userId = AdminAuth::getLoginId();
        $trip = Orders::select(['id'])->where('id', $id)->first();
        if($trip)
        {
        	$where = ["order_comments.order_id" => $id];
            if($request->has('last_id') && $request->get('last_id')) {
                $where["order_comments.id < ?"] = [$request->get('last_id')];
            }
            if(!Permissions::hasPermission('remarks', 'listing'))
            {
                $where["order_comments.admin_id = ?"] = [$userId];
            }
        	$listing = OrderComments::getListing($request, $where);
    	    $html = view(
        		"admin/partials/remarks", 
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
            return Response()->json([
                'status' => 'error'
            ]);
        }
    }

    function add(Request $request, $id)
    {
		$data = $request->toArray();
        $trip = Orders::select(['id'])->where('id', $id)->first();
        if($trip)
        {
            $user =  AdminAuth::getLoginUser();
            $validator = Validator::make(
                $data,
                [
                    'comment' => 'required'
                ]
            ); 
            if(!$validator->fails())
            {
                unset($data['_token']);
                $data['order_id'] = $trip->id;
                $data['admin_id'] = $user->id;
                $data['name'] = $user->first_name . ' ' . $user->last_name;
    	        $comment = OrderComments::create($data);
            	if($comment)
            	{
                    return Response()->json([
                        'status' => 'success',
                        'message' => 'Comment added.'
                    ]);
            	}
            	else
            	{
                    return Response()->json([
                        'status' => 'success',
                        'message' => 'Comment could not be save. Please try again.'
                    ]);
            	}
    	    }
    	    else
    	    {
    	    	return Response()->json([
                    'status' => 'success',
                    'message' => 'Please provide valid inputs.'
                ]);
    	    }
        }
        else
        {
            return Response()->json([
                'status' => 'error',
                'message' => 'Invalid request.'
            ]);
        }
    }

    function edit(Request $request, $id)
    {
        $data = $request->toArray();
        $comment = OrderComments::where('id', $id)->first();
        if($comment)
        {
            $userId =  AdminAuth::getLoginId();
            if(!Permissions::hasPermission('remarks', 'update') && $userId != $comment->admin_id)
            {
                $request->session()->flash('error', 'Permission denied.');
                return redirect()->route('admin.dashboard');
            }
            $validator = Validator::make(
                $data,
                [
                    'comment' => 'required',
                ]
            ); 
            if(!$validator->fails())
            {
                $log = [];
                $oldComment = $comment->toArray();
                $comment->comment = $data['comment'];
                if($comment->save())
                {
                    return Response()->json([
                        'status' => 'success',
                        'message' => 'Comment updated.',
                        'id' => $comment->id, 
                        'html' => $html = view(
                            "admin/partials/remarks", 
                            [
                                'listing' => OrderComments::getListing($request, ['order_comments.id' => $comment->id])
                            ]
                        )->render()
                    ]);
                }
                else
                {
                    return Response()->json([
                        'status' => 'error',
                        'message' => 'Comment could not be save. Please try again.'
                    ]);
                }
            }
            else
            {
                return Response()->json([
                    'status' => 'error',
                    'message' => 'Please provide valid inputs.'
                ]);
            }
        }
        else
        {
            return Response()->json([
                'status' => 'error',
                'message' => 'Invalid request.'
            ]);
        }
    }

    function delete(Request $request, $id)
    {
    	$comment = OrderComments::find($id);
        if($comment) 
    	{
            $userId =  AdminAuth::getLoginId();
            if($userId != $comment->admin_id)
            {
                return Response()->json([
                    'status' => 'error',
                    'message' => 'Permission deleted.'
                ]);
            }

            if(OrderComments::remove($id))
            {
        		return Response()->json([
                    'status' => 'success',
                    'message' => 'Comment deleted.'
                ]);
            }
            else
            {
                return Response()->json([
                    'status' => 'error',
                    'message' => 'Comment could not be deleted.'
                ]);
            }
    	}
    	else
    	{
            return Response()->json([
                'status' => 'error',
                'message' => 'Comment not found.'
            ]);
    	}
    }
}
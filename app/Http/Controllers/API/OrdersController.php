<?php

namespace App\Http\Controllers\API;

use App\Http\Resources\OrdersResource;
use Illuminate\Support\Facades\Validator;
use App\Models\API\Orders;
use App\Models\Admin\OrderProductRelation;
use App\Models\Admin\Settings;
use App\Models\API\Addresses;
use App\Models\API\Coupons;
use App\Models\API\Products;
use App\Models\API\Users;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class OrdersController extends BaseController
{

    /**
     * Fetch Orders as per customer.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCustomerOrders(Request $request, $token){
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false,
                    'authRequired' => true
                ]);
        }
        $orders = Orders::select([
            'id',
            'address', 
            'booking_date', 
            'booking_time', 
            'total_amount', 
            'status', 
            'created',
            DB::raw("(Select sum(quantity) from order_products op where op.order_id = orders.id limit 1) as service_count")
        ])->whereCustomerId($user->id)->orderBy('id', 'desc')->get();
        return Response()
                ->json([
                    'status' => true,
                    'data' => $orders,
                    'static' => Orders::getStaticData(),
                    'user' => $user
                ]);
    }

    public function detail(Request $request, $token, $id)
    {
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false,
                    'authRequired' => true
                ]);
        }
        $order = Orders::select([
            'id',
            'address', 
            'booking_date', 
            'booking_time', 
            'subtotal',
            'cgst',
            'sgst',
            'tax',
            'total_amount', 
            'status', 
            'created',
            DB::raw("(Select sum(quantity) from order_products op where op.order_id = orders.id limit 1) as service_count")
        ])->with(['products', 'products.brands'])->whereCustomerId($user->id)->where('id', $id)->orderBy('id', 'desc')->limit(1)->first();
        return Response()
                ->json([
                    'status' => true,
                    'data' => $order,
                    'static' => Orders::getStaticData(),
                    'user' => $user
                ]);
    }

    public function cancelBooking(Request $request, $token) {
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false,
                    'authRequired' => true
                ]);
        }
        $order = Orders::whereCustomerId($user->id)->where('id', $request->get('id'))->orderBy('id', 'desc')->limit(1)->first();
        if($order)
        {
            $order->status = 'cancel';
            if($order->save())
            {
                $order->updateStatusAndLogHistory('status', 'cancel_by_client', $order->id);

                $order = Orders::select([
                    'id',
                    'address', 
                    'booking_date', 
                    'booking_time', 
                    'subtotal',
                    'cgst',
                    'sgst',
                    'tax',
                    'total_amount', 
                    'status', 
                    'created',
                    DB::raw("(Select sum(quantity) from order_products op where op.order_id = orders.id limit 1) as service_count")
                ])->with(['products', 'products.brands'])->where('id', $order->id)->orderBy('id', 'desc')->limit(1)->first();

                return Response()->json([
                    'status' => true,
                    'order' => $order
                ]);
            }
        }
        return Response()->json([
            'status' => false,
        ]);
    }
    
	function createBooking(Request $request)
	{
		$data = $request->toArray();
		$validator = Validator::make(
			$data,
			[
                'token' => ['required'],
				'name' => ['required'],
				'date' => ['required', 'date'],
				'time' => ['required', 'after_or_equal:today'],
				'address' => ['required'],
				'cart' => ['required'],
                'cart' => ['required', 'array'],
                'cart.*.id' => ['required', Rule::exists(Products::class, 'id')->where(function ($query) {
                    $query->where('status', 1)->whereNull('deleted_at');
                })],
                'cart.*.quantity' => ['required', 'integer', 'min:1'],
			]
		);
		if(!$validator->fails())
		{
            $user = Users::select(['id', 'first_name'])->where('token', $data['token'])
                ->where('token_expiry', '>', date('Y-m-d H:i'))
                ->whereNotNull('token_expiry')
                ->where('status', 1)
                ->limit(1)
                ->first();
			if($user)
            {
                $order = new Orders();
                $order->customer_name = $user->first_name;
                $order->customer_id = $user->id;
                $order->manual_address = 1;
                $order->address = $data['address'];
                $order->booking_date = date('Y-m-d', strtotime($data['date']));
                $order->booking_time = date('H:i', strtotime($data['time']));
                $order->latitude = isset($data['lat']) && $data['lat'] ? $data['lat'] : null;
                $order->longitude = isset($data['lng']) && $data['lng'] ? $data['lng'] : null;
                $order->status = 'pending';
                $order->status_at = date('Y-m-d H:i:s');
                $order->created = date('Y-m-d H:i:s');
                if($order->save()) 
                {
                    $order->prefix_id = Settings::get('order_prefix') + $order->id;
                    $order->save();
                    $products = [];
                    $subtotal = 0;
                    foreach($data['cart'] as $c)
                    {
                        $product = Products::select(['id', 'title', 'price', 'description', 'duration_of_service'])->where('id', $c['id'])->limit(1)->first();
                        if($product)
                        {
                            $products[] = [
                                'order_id' => $order->id,
                                'product_id' => $product->id,
                                'product_title' => $product->title,
                                'product_description' => $product->description,
                                'amount' => $product->price,
                                'quantity' => $c['quantity'],
                                'duration_of_service' => $product->duration_of_service,
                                'updated_at' => now() 
                            ];

                            $subtotal += ($c['quantity'] * $product->price) > 0 ? $c['quantity'] * $product->price : 0;
                        }
                    }

                    if($products)
                    {
                        OrderProductRelation::insert($products);

                        $cgst = Settings::get('cgst');
                        $sgst = Settings::get('sgst');
                        $order->subtotal = $subtotal;
                        $order->discount = 0;
                        $order->cgst = $cgst;
                        $order->sgst = $sgst;
                        $order->tax = (($subtotal * $cgst) / 100) + (($subtotal * $sgst) / 100);
                        $order->total_amount = $order->subtotal + $order->tax;
                        $order->save();
                    }

                    return Response()->json([
                        'status' => true,
                        'orderId' => $order->prefix_id
                    ]);
                }
                else
                {
                    return Response()->json([
                        'status' => true
                    ]);
                }
            }
            else
            {
                return Response()
                    ->json([
                        'status' => false,
                        'authRequired' => true
                    ]);
            }
		}
		else
		{
            return Response()
                ->json([
                    'status' => false,
                    'clear' => true,
                    'message' => 'Something went wrong. Please try again.'
                ]);
		}
	}
}

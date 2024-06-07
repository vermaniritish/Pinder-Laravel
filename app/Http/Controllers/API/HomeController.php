<?php
/**
 * Home Class
 *
 * @package    HomeController
 
 
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
use App\Libraries\PositionStack;
use App\Models\API\SearchSugessions;
use App\Models\API\Products;
use App\Models\API\ApiAuth;
use App\Models\API\UsersMatches;
use App\Models\API\ProductCategories;
use App\Models\Admin\ProductCategoryRelation;
use App\Models\Admin\SearchKeywords;
use Illuminate\Support\Facades\DB;
use App\Libraries\FileSystem;
use App\Models\Admin\OrderProductRelation;
use App\Models\Admin\Orders;
use App\Models\Admin\Users;

class HomeController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function productsListing(Request $request)
	{
		$where = ['products.status' => 1];
		$products = Products::getListing($request, $where);
		$items = $products->items();
		return Response()->json([
			'status' => true,
			'products' => $items,
			'page' => $products->currentPage(),
			'counter' => $products->perPage(),
			'count' => $products->total(),
			'maxPage' => ceil($products->total()/$products->perPage()),
			'paginationMessage' => "Showing {$products->firstItem()} - {$products->lastItem()} of {$products->total()} results"

		]);
	}

	function productDetails(Request $request, $slug)
	{
		$userId = ApiAuth::getLoginId();
		$product = Products::getBySlug($slug);
		if($product)
		{
			$product->description = nl2br($product->description);
			$product->user_image = $product->users && $product->users->image ? $product->users->image : null;
			$catIds = $product->categories()->pluck('category_id')->toArray();
			$similarProducts = [];
			if(!empty($catIds))
			{
				$productIds = ProductCategoryRelation::whereIn('category_id', $catIds)
					->where('product_id', '!=', $product->id)
					->groupBy('product_id')
					->pluck('product_id')
					->toArray();
				if(!empty($productIds))
				{
					$where = ["products.id in (".implode(',', array_unique($productIds)).")", "products.status" => 1, 'sold' => 0];
					$similarProducts = Products::getListing($request, $where);
					if($userId)
					{
						foreach ($similarProducts as $key => $value) {
							$similarProducts[$key]->match_id = UsersMatches::where('user_id', $userId)->where('product_id', $value->id)->pluck('id')->first();
							$similarProducts[$key]->user_image = FileSystem::getAllSizeImages($value->user_image);
						}
					}
				}
			}
			
			$respond = DB::select('SELECT AVG(TIMESTAMPDIFF(MINUTE, created, read_at)) as response_seconds from messages where to_id = ' . $product->user_id . ' and read_at is not null;');
			$respond = $respond && $respond[0] && $respond[0]->response_seconds ? $respond[0]->response_seconds : null;
			return Response()->json([
		    	'status' => true,
	    		'product' => $product,
	    		'similar_products' => $similarProducts,
	    		'respond' => $respond
		    ]);
		}
		else
		{
			return Response()->json([
		    	'status' => false,
	    		'message' => 'Not Found!'
		    ], 400);
		}
	}

	function createBooking(Request $request)
	{
		$data = $request->toArray();
		$validator = Validator::make(
			$data,
			[
                'first_name' => ['required'],
				'last_name' => ['required'],
				'address' => ['required'],
				'postalcode' => ['required'],				
				'cart' => ['required'],
                'cart' => ['required', 'array'],
                'cart.*.quantity' => ['required', 'integer', 'min:1'],
			]
		);
		if(!$validator->fails())
		{
			$user = null;
			if($request->get('token')) {
				$userId = General::decrypt($request->get('token'));
				$user = Users::select(['id', 'email', 'phonenumber'])->where('id', $userId)->limit(1)->first();
			}
			$order = new Orders();
			$order->customer_id = $user ? $user->id : null;
			$order->first_name = $request->get('first_name');
			$order->last_name = $request->get('last_name');
			$order->company = $request->get('company');
			if($user)
			{
				$order->customer_email = $user->email;
				$order->customer_phone = $user->phonenumber;
			}
			else
			{

				$order->customer_email = $request->get('phone_email') && filter_var($request->get('phone_email'), FILTER_VALIDATE_EMAIL) !== false ? $request->get('phone_email') : null;
				$order->customer_phone = $request->get('phone_email') && filter_var($request->get('phone_email'), FILTER_VALIDATE_EMAIL) !== false ? null : $request->get('phone_email');
			}
			$order->manual_address = 1;
			$order->address = $data['address'];
			$order->area = ($data['address2'] ? $data['address2'] : null);
			$order->city = $data['city'];
			$order->postcode = $data['postalcode'];
			$order->coupon = isset($data['coupon']) && $data['coupon'] ? json_encode($data['coupon']) : null;
			$order->status = 'pending';
			$order->created = date('Y-m-d H:i:s');

			if($request->get('lastId'))
			{
				Orders::where('id', $request->get('orderId'))->where('status', 'pending')->where('paid', 0)->limit(1)->orderBy('id', 'desc')->delete();
			}

			if($order->save()) 
			{
				$order->prefix_id = Settings::get('order_prefix') + $order->id;
				$order->save();

				$products = [];
				$discount = 0;
				$subtotal = 0;
				$logoCost = 0;
				$oneTimeCost = Settings::get('one_time_setup_cost');
				$margin = 0;
				$includeTravelCharges = 0;
				foreach($data['cart'] as $c)
				{
					$products[] = [
						'order_id' => $order->id,
						'product_id' => $c['product_id'],
						'size_id' => $c['id'],
						'size_title' => $c['size_title'] . ' ' . $c['from_cm'] . ' - ' . $c['to_cm'],
						'color' => $c['color'],
						'product_title' => $c['title'],
						'product_description' => $c['size_title'] . ' ' . $c['from_cm'] . ' - ' . $c['to_cm']."\nChest:" . (isset($c['chest']) && $c['chest'] ? $c['chest'] : '') ."Waist: ".(isset($c['waist']) && $c['waist'] ? $c['waist'] : '')." Hip:".(isset($c['hip']) && $c['hip'] ? $c['hip'] : ''),
						'amount' => $c['price'],
						'quantity' => $c['quantity'],
						'logo_data' => isset($c['logo']) && $c['logo'] ? json_encode($c['logo']) : null
					];
					$logoCost += isset($c['logo']['price']) && $c['logo']['price'] > 0 ? ($c['logo']['price']*$c['quantity'])  : 0;
					$subtotal += $c['quantity'] * $c['price'];
				}

				if($products)
				{
					OrderProductRelation::insert($products);
					
					$link = url('/admin/order/'.$order->id.'/view');
					$subtotal += $logoCost;
					$subtotal += $oneTimeCost;

					$order->logo_cost = $logoCost;
					$order->one_time_cost = $oneTimeCost;
					$order->subtotal = $subtotal;
					$order->tax_percentage = Settings::get('gst');

					if(isset($data['coupon']) && $data['coupon'] && $data['coupon']['is_percentage'] > 0 && $data['coupon']['amount'] > 0) {
						$discount = ($subtotal * $data['coupon']['amount'])/100;
					}
					elseif(isset($data['coupon']) && $data['coupon'] && $data['coupon']['amount'] > 0) {
						$discount = $data['coupon']['amount'] > $subtotal ? $subtotal : $data['coupon']['amount'];
					}
					$order->discount = $discount;
					$order->tax_percentage = Settings::get('gst');
					$order->tax = (($subtotal - $discount) * $order->tax_percentage) / 100;
					$order->total_amount = ($subtotal - $discount) + $order->tax;
					$order->save();
					// $pros = [];
					// $listing = OrderProductRelation::getListing($request, ['order_products.order_id' => $order->id]);
					// if($listing->count() > 0)
					// foreach($listing->items() as $k => $row):
					// 	$pros[] = "o {$row->product_title} | *Qty: {$row->quantity}* | *Time: ".(_t($row->duration_of_service))."*";
					// endforeach;
					// $textMessage = "A new service assigned to " . ($order->staff ? $order->staff->first_name . " ".$order->staff->last_name : '') . " \nId: *{$order->prefix_id}*\nCustomer Name: *{$order->customer_name} - " . ($order->customer ? $order->customer->phonenumber : '') . "*\nAddress: *".implode(', ', array_filter([$order->address]))."*\nBooking Time: *"._d($order->booking_date)." | " . _time($order->booking_time) ."*\n".($order->latitude && $order->longitude ? "Locations:\nhttps://maps.google.com/maps?q={$order->latitude},{$order->longitude}&z=17&hl=en" : "")."\n----------------------------\n".implode("\n", $pros);

					// $codes = [
					// 	'{order_id}' => $order->prefix_id,
					// 	'{order_information}' => nl2br($textMessage),
					// 	'{order_button}' => '<br /><br /><a href="'.$link.'" target="_blank" style="padding:30px;background:pink;">View Order</a>'
					// ];

					// General::sendTemplateEmail(
					// 	'amitaverma736@gmail.com',
					// 	'order-placed',
					// 	$codes
					// );
				}

				return Response()->json([
					'status' => true,
					'orderId' => $order->prefix_id,
					'amount' => $order->total_amount
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
                    'clear' => true,
                    'message' =>  current( current( $validator->errors()->getMessages() ) )
                ]);
		}
	}
}
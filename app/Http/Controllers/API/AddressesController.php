<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;
use App\Http\Resources\AddressesResource;
use App\Models\Admin\AdminAuth;
use App\Models\API\Addresses;
use App\Models\API\Users;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class AddressesController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function listing(Request $request)
    {
        $data = $request->toArray();
        $token = isset($data['token']) && $data['token'] ? $data['token'] : null;
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
        $addresses = Addresses::where('user_id', $user->id)
            ->orderBy('id', 'desc')
            ->limit(50)
            ->get();
        return Response() ->json([
                'status' => true,
                'cities' => ["Chandighar", "Mohali", "Panchkula", "Ludhiana"],
                'addresses' => $addresses
            ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function add(Request $request)
    {
        $data = $request->toArray();
        $token = isset($data['token']) && $data['token'] ? $data['token'] : null;
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

		$validator = Validator::make(
			$data,
			[
                'address' => ['required','string','max:255',],
                'city' => ['required','string','max:255',],
                'token' => ['required','string','max:255'],
                'latitude' => ['numeric','nullable'],
                'longitude' => ['numeric','nullable']
			]
		);
        if(!$validator->fails())
        {
            $data['user_id'] = $user->id;
            unset($data['token']);
            $address = Addresses::create($data);
            if($address)
            {
                return Response()
                    ->json([
                        'status' => true,
                        'address' => $address
                    ]);
            }
            else
            {
                return Response()
                    ->json([
                        'status' => false,
                        'message' => 'Address could not be saved.'
                    ]);
            }
        }
        else
		{
            return Response()
                ->json([
                    'status' => false,
                    'message' => current( current( $validator->errors()->getMessages() ) )
                ]);
		}
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, string $id)
    {
        $check_brand = Addresses::whereId($id)->where('user_id', $request->user()?->id)->exists();
        if (!$check_brand) {
            return $this->error(trans('ADDRESS_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }
        $input = $request->validate([
            'title' => ['filled','string','max:255',],
            'address' => ['filled','string','max:255',],
            'city' => ['filled','string','max:255',],
            'state' => ['filled','string','max:255',],
            'area' => ['filled','string','max:255',],
            'latitude' => ['filled','numeric',],
            'longitude' => ['filled','numeric',]
        ]);

        Addresses::whereId($id)->update($input);

        return $this->success([], Response::HTTP_OK, trans('ADDRESSS_UPDATED'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete(Request $request)
    {
        $data = $request->toArray();
        $id = $request->get('id');
        $token = isset($data['token']) && $data['token'] ? $data['token'] : null;
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false
                ]);
        }

        $check_address = Addresses::whereId($id)->where('user_id', $user->id)->first();
        if($check_address)
        {
            if($check_address->delete())
            {
                return Response()->json([
                    'status' => true
                ]);
            }
        }

        return Response()->json([
            'status' => false
        ]);
    }

}

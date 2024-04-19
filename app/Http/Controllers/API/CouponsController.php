<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController;
use Illuminate\Http\Request;
use App\Http\Resources\CouponsResource;
use App\Models\Admin\Coupons;
use App\Models\API\Coupons as APICoupons;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class CouponsController extends BaseController
{
    public function index(Request $request)
    {
        $coupon = Coupons::where('coupon_code', 'LIKE', $request->get('code'))->where('status', 1)->limit(1)->first();
        if (!$coupon) {
            return $this->error(trans('CATEGORY_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->_index($request, APICoupons::class, new CouponsResource($coupon), ['usageNotExceeded','notExpired']);
    }
}
<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController;
use Illuminate\Http\Request;
use App\Http\Resources\CouponsResource;
use App\Models\API\Coupons as APICoupons;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class CouponsController extends BaseController
{
    public function index(Request $request)
    {
        return $this->_index($request, APICoupons::class, CouponsResource::class, ['usageNotExceeded','notExpired']);
    }
}

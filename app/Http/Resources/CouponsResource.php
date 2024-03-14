<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class CouponsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
                'id'   =>  $this->id,
                'coupon_code' =>  $this->coupon_code,
                'title' =>  $this->title,
                'description' =>  $this->description,
                'amount' => $this->amount,
                'is_percentage' => $this->is_percentage,
                'min_amount' => $this->min_amount,
        ];
    }
}

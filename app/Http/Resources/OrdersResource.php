<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class OrdersResource extends JsonResource
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
            'id' => $this->id,
            'customer_id' => $this->customer_id,
            'customer_name' => $this->customer_name,
            'address' => $this->address,
            // 'state' => $this->state,
            // 'city' => $this->city,
            // 'area' => $this->area,
            'booking_date' => $this->booking_date,
            'booking_time' => $this->booking_time,
            // 'payment_type' => $this->payment_type,
            'subtotal' => $this->subtotal,
            'tax' => $this->tax,
            'discount' => $this->discount,
            'total_amount' => $this->total_amount,
            'coupon_code_id' => $this->coupon_code_id,
            'products' => $this->products->map(function ($product) {
                return [
                    'id' => $product->id,
                    'title' => $product->pivot->product_title,
                    'quantity' => $product->pivot->quantity,
                    'amount' => $product->pivot->amount,
                    'duration_of_service' => $product->pivot->duration_of_service,
                    'product_description' => $product->pivot->product_description,
                ];
            }),
        ];
    }
}

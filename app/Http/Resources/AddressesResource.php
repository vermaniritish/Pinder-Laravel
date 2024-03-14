<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class AddressesResource extends JsonResource
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
                'title' =>  $this->title,
                'address' =>  $this->address,
                'city' =>  $this->city,
                'state' =>  $this->state,
                'area' => $this->area,
                'latitude' => $this->latitude,
                'longitude' => $this->longitude,
        ];
    }
}

<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class ProductsResource extends JsonResource
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
            'title' => $this->title,
            'description' => $this->description,
            'price' => $this->price,
            'sale_price' => $this->sale_price,
            'address' => $this->address,
            'duration_of_service' => $this->duration_of_service,
            'image' => $this->image,
            'tag' => $this->tags,
            'brands' => BrandsResource::collection($this->brands)->values(),
            'categories' => ProductCategoriesResource::collection($this->whenLoaded('categories'))
    ];
    }
}

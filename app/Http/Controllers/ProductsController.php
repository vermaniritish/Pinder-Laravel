<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use App\Models\Products;
use App\Models\Brands;
use App\Http\Resources\ProductsResource;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class ProductsController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        return $this->_index($request, Products::class, ProductsResource::class, []);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $input = $request->validate([
            'brand_id' => ['required','string',Rule::exists(Brands::class, 'id')],
            'product_name' => ['required', 'string','max:40'],
            'product_description' => ['required', 'string', 'max:255'],
            'product_categories' => ['required','array'],
            'product_categories.*' => ['string','max:40'],
            'image' => ['required','image','max:2048'],
            'price' => ['required', 'integer'],
            'sale_price' => ['required', 'integer'],
        ]);
        $input['id'] = Str::uuid();
        $image = $input['image'];
        $image_extension = $image->getClientOriginalExtension();
        $filename = Str::uuid() . '.' . $image_extension;
        Storage::disk('products_images')->put($filename, $image->getContent());
        unset($input['image']);
        $input['image_name'] = $filename;
        $input['image_path'] = Storage::disk('products_images')->path('');

        Products::create($input);

        return $this->success([], Response::HTTP_OK, trans('PRODUCT_CREATED'));
    }

    /**
     * Display the specified resource.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        $check_product = Products::whereId($id)->first();
        if (!$check_product) {
            return $this->error(trans('PRODUCT_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->success(new ProductsResource($check_product), Response::HTTP_OK);
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
        $check_product = Products::whereId($id)->first();
        if (!$check_product) {
            return $this->error(trans('PRODUCT_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $input = $request->validate([
            'brand_id' => ['required','string',Rule::exists(Brands::class, 'id')],
            'product_name' => ['filled', 'string','max:40'],
            'product_description' => ['filled', 'string', 'max:255'],
            'product_categories' => ['filled','array'],
            'product_categories.*' => ['string','max:40'],
            'image' => ['filled','image','max:2048'],
            'price' => ['filled', 'integer'],
            'sale_price' => ['filled', 'integer'],
        ]);

        if($request->has('image')) {
            $image = $input['image'];
            $image_extension = $image->getClientOriginalExtension();
            $filename = Str::uuid() . '.' . $image_extension;
            Storage::disk('products_images')->put($filename, $image->getContent());
            unset($input['image']);
            $input['image_name'] = $filename;
            $input['image_path'] = Storage::disk('products_images')->path('');
        }

        Products::whereId($id)->update($input);

        return $this->success([], Response::HTTP_OK, trans('PRODUCT_UPDATED'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $check_product = Products::whereId($id)->first();
        if (!$check_product) {
            return $this->error(trans('PRODUCT_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $check_product->delete();

        return $this->success([], Response::HTTP_OK, trans('PRODUCT_DELETED'));
    }
}

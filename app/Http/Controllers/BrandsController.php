<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\BaseController;
use App\Models\Brands;
use App\Http\Resources\BrandsResource;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class BrandsController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        return $this->_index($request, Brands::class, BrandsResource::class, []);
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
            'brand_name' => ['required', 'string','max:40'],
            'brand_description' => ['nullable', 'string', 'max:255'],
            'image' => ['required','image','max:2048']
        ]);
        $input['id'] = Str::uuid();
        $image = $input['image'];
        $image_extension = $image->getClientOriginalExtension();
        $filename = Str::uuid() . '.' . $image_extension;
        Storage::disk('brand_images')->put($filename, $image->getContent());
        unset($input['image']);
        $input['image_name'] = $filename;
        $input['image_path'] = Storage::disk('brand_images')->path('');

        Brands::create($input);

        return $this->success([], Response::HTTP_OK, trans('BRAND_CREATED'));
    }

    /**
     * Display the specified resource.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        $check_brand = Brands::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('BRAND_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->success(new BrandsResource($check_brand), Response::HTTP_OK);
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
        $check_brand = Brands::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('BRAND_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $input = $request->validate([
            'brand_name' => ['filled', 'string','max:40'],
            'brand_description' => ['filled', 'string', 'max:255'],
            'image' => ['required','image','max:2048']

        ]);

        if($request->has('image')) {
            $image = $input['image'];
            $image_extension = $image->getClientOriginalExtension();
            $filename = Str::uuid() . '.' . $image_extension;
            Storage::disk('brand_images')->put($filename, $image->getContent());
            unset($input['image']);
            $input['image_name'] = $filename;
            $input['image_path'] = Storage::disk('brand_images')->path('');
        }

        Brands::whereId($id)->update($input);

        return $this->success([], Response::HTTP_OK, trans('BRAND_UPDATED'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $check_brand = Brands::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('BRAND_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $check_brand->delete();

        return $this->success([], Response::HTTP_OK, trans('BRAND_DELETED'));
    }

}

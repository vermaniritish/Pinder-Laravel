<?php

namespace App\Models\Admin;

use App\Models\AppModel;

class HomePage extends AppModel
{
    protected $table = 'homepage';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**
     * Fetch option value
     *
     * @param  string $key
     * @return Response
     */
    public static function get($key)
    {
    	return self::where('key', $key)->limit(1)->pluck('value')->first();
    }


    /**
     * Update option value
     *
     * @param  HomePage $key
     * @return Response
     */
    public static function put($key, $value)
    {
        $option = self::where('key', $key)->limit(1)->first();
        if($option)
        {
            $option->value = $value ? $value : "";
            return $option->save();
        }
        else
        {
            $option = new HomePage();
            $option->key = $key;
            $option->value = $value;
            return $option->save();
        }
        return false;
    }



}

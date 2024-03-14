<?php

namespace App\Models\Admin;

use App\Models\AppModel;

class Settings extends AppModel
{
    protected $table = 'settings';
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
    	return self::where('name', $key)->limit(1)->pluck('value')->first();
    }


    /**
     * Update option value
     *
     * @param  Settings $key
     * @return Response
     */
    public static function put($key, $value)
    {
        $option = self::where('name', $key)->limit(1)->first();
        if($option)
        {
            $option->value = $value ? $value : "";
            return $option->save();
        }
        else
        {
            $option = new Settings();
            $option->name = $key;
            $option->value = $value;
            return $option->save();
        }
        return false;
    }


    public static function dateFormats()
    {
        $formats = [
            'd-m-Y' => 'DD-MM-YYYY',
            'd/m/Y' => 'DD/MM/YYYY',
            'm-d-Y' => 'MM-DD-YYYY',
            'm/d/Y' => 'MM/DD/YYYY',
            'Y-m-d' => 'YYYY-MM-DD'
        ];
        return $formats;
    }

    public static function timeFormats()
    {
        $formats = [
            'H:i' => '24 hours',
            'h:i a' => '12 hours'
        ];
        return $formats;
    }

    public static function timeZones()
    {
        $zones = [
            ['label' => 'EUROPE', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::EUROPE)],
            ['label' => 'AMERICA', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::AMERICA)],
            ['label' => 'INDIAN', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::INDIAN)],
            ['label' => 'AUSTRALIA', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::AUSTRALIA)],
            ['label' => 'ASIA', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::ASIA)],
            ['label' => 'AFRICA', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::AFRICA)],
            ['label' => 'ANTARCTICA', 'options' =>\DateTimeZone::listIdentifiers(\DateTimeZone::ANTARCTICA)],
            ['label' => 'ARCTIC', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::ARCTIC)],
            ['label' => 'ATLANTIC', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::ATLANTIC)],
            ['label' => 'PACIFIC', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::PACIFIC)],
            ['label' => 'UTC', 'options' => \DateTimeZone::listIdentifiers(\DateTimeZone::UTC)]
        ];
        return $zones;
    }

}

<?php
namespace App\Libraries;

use App\Models\Admin\Settings;
use Illuminate\Support\Facades\Http;

class Google
{
	public static function verifyLogin($accessToken)
	{
		$response = Http::asForm()
			->get('https://www.googleapis.com/oauth2/v1/userinfo?access_token=' . $accessToken);
		return $response->successful() && $response->json() && isset($response->json()['id']) && $response->json()['id'] ? $response->json() : null;	
	}

	public static function getAddressCoordinates($address)
	{

		$key = Settings::get('google_api_key');
		$address = str_replace(" ", "+", $address);
		$response = Http::asForm()
			->get("https://maps.google.com/maps/api/geocode/json?address=".urlencode($address)."&sensor=false&region=gb&key=" . $key);
		return $response->successful() && $response->json() ? $response->json() : null;
	}
}
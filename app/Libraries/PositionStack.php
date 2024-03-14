<?php
/**
 * PositionStack
 *
 * @package    https://positionstack.com/
 
 */

namespace App\Libraries;

use Illuminate\Support\Facades\Http;
use App\Models\Admin\Settings;

class PositionStack
{

	/**
	* To fetch postcode and address
	* @param $token 
	**/
	public static function search($search)
	{
		$apiKey = Settings::get('position_stack_api_key');
		$countryCode = Settings::get('position_stack_target_country');
		$response = Http::get(
				"http://api.positionstack.com/v1/forward?access_key={$apiKey}&country={$countryCode}&limit=20&fields=results.latitude,results.longitude,results.label,results.postal_code&query=" . $search
			);
		return $response->successful() && $response->json() && isset($response->json()['data']) ? $response->json()['data'] : [];
	}

	
}
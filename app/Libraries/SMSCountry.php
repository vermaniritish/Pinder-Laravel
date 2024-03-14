<?php
namespace App\Libraries;

use App\Models\Admin\Settings;
use Illuminate\Support\Facades\Http;

class SMSCountry
{
	public static function send($phoneNumber, $message)
	{
		$username = 'KccaE7HV232iHX4gY7jc';
		$password = 'iPVq83kRiunO7jMgAJYowOFlbTLPq12LUJwP4pSI';
		if(strpos(request()->getHttpHost(), 'shaguna') > -1)
		{
			$response = Http::withBasicAuth($username, $password)
				->post('https://restapi.smscountry.com/v0.1/Accounts/'.$username.'/SMSes/', [
					'Text' => $message,
					'Number' => '91'.$phoneNumber,
					'SenderId' => 'SHAGNA',
					"DRNotifyUrl"=> "",
					'DRNotifyHttpMethod'=> "POST",
					"Tool"=> "API"
				]);
			return $response->successful() && $response->json() ? $response->json() : null;	
		}
		else
		{
			return true;
		}
	}
}
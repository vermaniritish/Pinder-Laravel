<?php
namespace App\Libraries;

use App\Models\Admin\Settings;

class Facebook
{

	public static function connect()
	{
		return new \Facebook\Facebook([
		  'app_id' => Settings::get('facebook_app_id'),
		  'app_secret' => Settings::get('facebook_app_secret'),
		  'default_graph_version' => Settings::get('facebook_api_version'),
		]);
	}


	public static function verifyLogin($accessToken)
	{
		$fb = self::connect();

		try {
		  
		  $response = $fb->get('/me', $accessToken);
		} catch(\Facebook\Exceptions\FacebookResponseException $e) {
		  // When Graph returns an error
		  echo 'Graph returned an error: ' . $e->getMessage();
		  exit;
		} catch(\Facebook\Exceptions\FacebookSDKException $e) {
		  // When validation fails or other local issues
		  echo 'Facebook SDK returned an error: ' . $e->getMessage();
		  exit;
		}

		$me = $response->getGraphUser();
		return $me && $me->getId() ? $me->getId() : null;
	}

	public static function getInfo($accessToken)
	{
		$fb = self::connect();

		try {
		  
		  $response = $fb->get('/me?fields=id,name,email,picture', $accessToken);
		} catch(\Facebook\Exceptions\FacebookResponseException $e) {
		  // When Graph returns an error
		  echo 'Graph returned an error: ' . $e->getMessage();
		  exit;
		} catch(\Facebook\Exceptions\FacebookSDKException $e) {
		  // When validation fails or other local issues
		  echo 'Facebook SDK returned an error: ' . $e->getMessage();
		  exit;
		}

		return $response->getGraphUser();
	}
}
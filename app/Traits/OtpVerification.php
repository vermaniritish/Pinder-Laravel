<?php

namespace App\Traits;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use Tzsk\Otp\Facades\Otp;

trait OtpVerification {
	/**
	 * Generate session key for the user.
	 *
	 * @return  string  The session key
	 */
	public function generateSessionKey() {
		$session_key = Str::random(10);
		Cache::put('users.session_keys.' . $session_key, $this, 10 * 60);

		return $session_key;
	}

	/**
	 * Get the user from the session key.
	 *
	 * @param  string  $session_key
	 * @return \App\Models\User|null
	 */
	public static function getUserFromSessionKey($session_key) {
		return Cache::get('users.session_keys.' . $session_key);
	}

	/**
	 * Expire the session key for the user.
	 *
	 * @param  string  $session_key
	 *
	 * @return void
	 */
	public function expireSessionKey($session_key) {
		Cache::delete('users.session_keys.' . $session_key);
	}

	/**
	 * Generate email verification otp.
	 *
	 * @param  string  $secret_key
	 *
	 * @return  bool
	 */
	public function generateEmailVerificationOtp($secret_key) {
		return Otp::generate('users.' . $this->getKey() . '.email.verification.otp.' . $secret_key);
	}

	/**
	 * Check email verification otp.
	 *
	 * @param  string  $otp
	 * @param  string  $secret_key
	 *
	 * @return  bool
	 */
	public function checkEmailVerificationOtp($otp, $secret_key) {
		return Otp::check($otp, 'users.' . $this->getKey() . '.email.verification.otp.' . $secret_key);
	}

	/**
	 * Generate phone verification otp.
	 *
	 * @param  string  $secret_key
	 *
	 * @return  bool
	 */
	public function generatePhoneVerificationOtp($secret_key) {
		return Otp::generate('users.' . $this->getKey() . '.phone.verification.otp.' . $secret_key);
	}

	/**
	 * Check email verification otp.
	 *
	 * @param  string  $otp
	 * @param  string  $secret_key
	 *
	 * @return  bool
	 */
	public function checkPhoneVerificationOtp($otp, $secret_key) {
		return Otp::check($otp, 'users.' . $this->getKey() . '.phone.verification.otp.' . $secret_key);
	}

	/**
	 * Send phone verification otp.
	 *
	 * @param  string  $email
	 * @param  string  $otp
	 * @param  string  $phone_number
	 * @return  bool
	 */
	public function sendPhoneVerificationOtp($email, $otp, $phone_number) {
		$response = Http::asForm()->post('https://control.msg91.com/api/sendhttp.php', [
			'authkey' => '39052Ab0RD0uNOcXQ571a278a',
			'sender' => 'Nebero',
			'mobiles' => $phone_number,
			'message' => 'Welcome to Nebero Systems. Your Internet access details are: Username:' . $email . ' Password:' . $otp,
			'route' => '4',
			'DLT_TE_ID' => '1007165095712663245'
		]);

		return $response->getBody();
	}
}

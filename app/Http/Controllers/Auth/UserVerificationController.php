<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Traits\OtpVerification;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class UserVerificationController extends Controller {
	/**
	 * Resend email verification otp.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function resendEmailVerificationOtp(Request $request) {
		$input = $request->validate([
			'session_key' => ['required', 'string'],
		]);
		$session_key = $input['session_key'];

		$user = OtpVerification::getUserFromSessionKey($session_key);
		if (is_null($user)) {
			return $this->error(trans('INVALID_SESSION_KEY'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		if ($user->hasVerifiedEmail()) {
			return $this->error(trans('EMAIL_ALREADY_VERIFIED'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		$email_otp = $user->generateEmailVerificationOtp($session_key);
		$user->sendEmailVerificationOtpNotification($email_otp);

		return $this->success([], Response::HTTP_OK, trans('EMAIL_OTP_RESENT'));
	}

	/**
	 * Resend phone verification otp.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function resendPhoneVerificationOtp(Request $request) {
		$input = $request->validate([
			'session_key' => ['required', 'string'],
		]);
		$session_key = $input['session_key'];

		$user = OtpVerification::getUserFromSessionKey($session_key);
		if (is_null($user)) {
			return $this->error(trans('INVALID_SESSION_KEY'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		if ($user->phone_number_verified_at) {
			return $this->error(trans('PHONE_NUMBER_ALREADY_VERIFIED'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		$phone_otp = $user->generatePhoneVerificationOtp($session_key);
		$user->sendPhoneVerificationOtp($user->email, $phone_otp, $user->phone_number);

		return $this->success([], Response::HTTP_OK, trans('PHONE_OTP_RESENT'));
	}
}

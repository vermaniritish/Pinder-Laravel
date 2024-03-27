<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;
use Illuminate\Validation\Rules\Password;

class AuthController extends Controller {
	/**
	 * Register the user for matrimonial.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function register(Request $request) {
    	if($request->isMethod('post')){
			$credentials = $request->validate([
				'email' => ['required', 'email', Rule::unique(User::class, 'email')],
				'phone_number' => [
					'required', 'regex:/^\+\d{1,3}\d{5,15}$/',
					Rule::unique(User::class, 'phone_number')
				],
				'password' => [
					'required', 'string',
					Password::min(12)->mixedCase()->numbers()->symbols()->uncompromised(), 'max:36'
				],
				'password_confirmation' => ['required', 'same:password'],
				'profile_for' => [
					'required', 'string',
					Rule::in(['Self', 'Son', 'Daughter', 'Relative', 'Friend', 'Sister', 'Brother', 'Client Marriage Bureau'])
				],
				'gender' => ['required', 'string', 'in:Male,Female'],
				'firstname' => ['required', 'string', 'max:30'],
				'lastname' => ['required', 'string', 'max:30'],
				'privacy_policy_accepted' => ['required', Rule::in([true])]
			], [
				'privacy_policy_accepted.required' => trans('validation.accepted'),
				'privacy_policy_accepted.in' => trans('validation.accepted')
			]);
	
			$phone_number_format = config('otp.phone_number_format');
	
			if ($phone_number_format == 'without_plus_sign') {
				$phone_number = Str::replace('+', '', $credentials['phone_number']);
			} else {
				$phone_number = $credentials['phone_number'];
			}
	
			$credentials['id'] = Str::uuid();
			$credentials['password'] = Hash::make($credentials['password']);
			$credentials['provider'] = 'matrimonial';
			User::create($credentials);
	
			$user = User::whereEmail($credentials['email'])->first();
			$session_key = $user->generateSessionKey();
			$email_otp = $user->generateEmailVerificationOtp($session_key);
			$user->sendEmailVerificationOtpNotification($email_otp);
			$phone_otp = $user->generatePhoneVerificationOtp($session_key);
			$user->sendPhoneVerificationOtp($credentials['email'], $phone_otp, $phone_number);
			Artisan::call('privacy:seed ' . $credentials['id']);
	
			return response()->json([
				'message' => trans('REGISTER_SUCCESSFULL'),
				'email' => $user->email,
				'user_id' => $credentials['id'],
				'session_key' => $session_key
			], Response::HTTP_OK);
		}
		return view('frontend.auth.auth');
	}

	/**
	 * User login for matrimonial.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function login(Request $request) {
		$credentials = $request->validate([
			'email' => [
				'required', 'bail', 'string', 'max:255', 'email',
				Rule::exists(User::class, 'email')->where('provider', 'matrimonial')
			],
			'password' => ['required', 'string', 'max:24']
		]);

		$user = User::whereEmail($credentials['email'])->first();

		$password = $credentials['password'];
		if (!$user || $credentials['password'] != Hash::check($password, $user->password)) {
			return response()->json(['message' => trans('INVALID_CREDENTIALS')], Response::HTTP_UNAUTHORIZED);
		}

		if (!$user->hasVerifiedEmail()) {
			$session_key = $user->generateSessionKey();
			$email_otp = $user->generateEmailVerificationOtp($session_key);
			$user->sendEmailVerificationOtpNotification($email_otp);
			$phone_otp = $user->generatePhoneVerificationOtp($session_key);
			$user->sendPhoneVerificationOtp($credentials['email'], $phone_otp, $user->phone_number);

			return $this->error(trans('EMAIL_IS_NOT_VERIFIED'), Response::HTTP_UNAUTHORIZED, ['session_key' => $session_key]);
		}

		$token = $user->createToken($request->email)->plainTextToken;

		User::whereEmail($credentials['email'])->update([
			'last_login_at' => Carbon::now()->timestamp,
			'last_login_ip' => $request->getClientIp(),
		]);

		return $this->success([
			'sucess' => true, 'token' => $token,
			'user_id' => $user->id
		], Response::HTTP_OK, trans('LOGIN_SUCCESSFUL'));
	}

	/**
	 * Remove the specified resource
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function destroy(Request $request) {
		$request->user()->currentAccessToken()->delete();

		return response()->json([
			'sucess' => true,
			'message' => __('response.LOGOUT_SUCCESSFULL'),
		], Response::HTTP_OK);
	}

	/**
	 * Update user password.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function updatePassword(Request $request) {
		$credentials = $request->validate([
			'email' => ['required', 'string', 'min:6', 'email', Rule::exists(User::class, 'email')],
			'current_password' => ['required', 'string', 'min:8', 'max:12'],
			'new_password' => [
				'required', 'string',
				Password::min(8)->mixedCase()->numbers()->symbols()->uncompromised(), 'max:12'
			],
			'confirmed_password' => ['required', 'same:new_password'],
		]);
		$user = User::whereEmail($credentials['email'])->first();
		$password = $credentials['current_password'];

		if (!$user || $credentials['current_password'] != Hash::check($password, $user->password)) {
			return response()->json(['message' => trans('INVALID_CREDENTIALS')], Response::HTTP_UNAUTHORIZED);
		}

		User::whereEmail($credentials['email'])->update([
			'password' => Hash::make($credentials['new_password']),
			'updated_at' => Carbon::now()->timestamp
		]);

		return response()->json([
			'sucess' => true,
			'message' => trans('PASSWORD_UPDATED_SUCCESSFULLY'),
		], Response::HTTP_OK);
	}

	/**
	 * Verify email verification otp.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function verifyVerificationOtp(Request $request) {
		$input = $request->validate([
			'email' => [
				'bail', 'required', 'email', Rule::exists(User::class, 'email')
			],
			'phone_otp' => ['required', 'string'],
			'email_otp' => ['required', 'string'],
			'key' => ['required', 'string'],
		]);

		$phone_otp = $input['phone_otp'];
		$email_otp = $input['email_otp'];
		$key = $input['key'];
		$email = $input['email'];

		$user = User::whereEmail($email)->first();
		if ($user->hasVerifiedEmail() && $user->phone_number_verified_at) {
			return $this->error(trans('USER_ALREADY_VERIFIED'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		if (!$user->checkEmailVerificationOtp($email_otp, $key)) {
			return $this->error(trans('INVALID_EMAIL_OTP'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}
		if (!$user->checkPhoneVerificationOtp($phone_otp, $key)) {
			return $this->error(trans('INVALID_PHONE_NUMBER_OTP'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		$user->email_verified_at = Carbon::now()->toDateTimeString();
		$user->phone_number_verified_at = Carbon::now()->toDateTimeString();
		$user->save();
		$token = $user->createToken($email)->plainTextToken;

		return $this->success(['token' => $token, 'email' => $email], Response::HTTP_OK, trans('USER_VERIFIED_SUCCESSFULLY'));
	}

	/**
	 * Verify phone number verification otp.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function verifyPhoneVerificationOtp(Request $request) {
		$input = $request->validate([
			'email' => [
				'bail', 'required', 'email', Rule::exists(User::class, 'email')
			],
			'otp' => ['required', 'string'],
			'key' => ['required', 'string'],
		]);

		$otp = $input['otp'];
		$key = $input['key'];
		$email = $input['email'];

		$user = User::whereEmail($email)->first();

		if ($user->phone_number_verified_at) {
			return $this->error(trans('PHONE_NUMBER_ALREADY_VERIFIED'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		if (!$user->checkPhoneVerificationOtp($otp, $key)) {
			return $this->error(trans('INVALID_PHONE_NUMBER_OTP'), Response::HTTP_UNPROCESSABLE_ENTITY);
		}

		$user->phone_number_verified_at = Carbon::now()->toDateTimeString();
		$user->save();

		return $this->success(['email' => $email], Response::HTTP_OK, trans('USER_VERIFIED_SUCCESSFULLY'));
	}
}

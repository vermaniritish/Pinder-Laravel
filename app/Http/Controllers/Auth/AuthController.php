<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Libraries\General;
use App\Models\Admin\Users;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
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
    		$data = $request->toArray();
			$validator = Validator::make(
	            $request->toArray(),
	            [
					'email' => ['required', 'email', Rule::unique(Users::class, 'email')],
					'password' => [
						'required', 'string',
						Password::min(8)->mixedCase()->numbers()->symbols()->uncompromised(), 'max:36'
					],
					'password_confirmation' => ['required', 'same:password'],
					'first_name' => ['required', 'string', 'max:30'],
	            ]
	        );
			if(!$validator->fails())
	        {
				$data['password'] = Hash::make($data['password']);
				unset($data['password_confirmation']);
				unset($data['_token']);
				$user = Users::create($data);
				$user = Users::whereEmail($data['email'])->first();
				$session_key = $user->generateSessionKey();
				$email_otp = $user->generateEmailVerificationOtp($session_key);
				$codes = [
					'{id}' => $user->id,
					'{otp}' => $email_otp
				];
				$emails = [
					$data['email']
				];
				General::sendTemplateEmail($emails, 'registration', $codes);
				return response()->json([
					'message' => trans('REGISTER_SUCCESSFULL'),
					'email' => $user->email,
					'user_id' => $user->id,
					'session_key' => $session_key
				], Response::HTTP_OK);
			} else {
				return Response()->json([
					'status' => false,
					'message' => current(current($validator->errors()->getMessages()))
				], Response::HTTP_OK);
			}
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
		$data = $request->toArray();
		$validator = Validator::make(
			$data,
			[
				'email' => [
					'required', 'bail', 'string', 'max:255', 'email',
					Rule::exists(Users::class, 'email')
				],
				'password' => ['required', 'string', 'max:36']
			]
		);
		if(!$validator->fails())
		{
			$user = Users::whereEmail($data['email'])->first();
			$password = $data['password'];
			if (!$user || $data['password'] != Hash::check($password, $user->password)) {
				return response()->json(['message' => trans('INVALID_CREDENTIALS')], Response::HTTP_UNAUTHORIZED);
			}
			if (!$user->hasVerifiedEmail()) {
				$session_key = $user->generateSessionKey();
				$email_otp = $user->generateEmailVerificationOtp($session_key);
				$user->sendEmailVerificationOtpNotification($email_otp);
				$phone_otp = $user->generatePhoneVerificationOtp($session_key);
				$user->sendPhoneVerificationOtp($data['email'], $phone_otp, $user->phone_number);
	
				return $this->error(trans('EMAIL_IS_NOT_VERIFIED'), Response::HTTP_UNAUTHORIZED, ['session_key' => $session_key]);
			}
			$token = $user->createToken($request->email)->plainTextToken;
			Users::whereEmail($data['email'])->update([
				'last_login_at' => Carbon::now()->timestamp,
				'last_login_ip' => $request->getClientIp(),
			]);
			return $this->success([
				'sucess' => true, 
				'token' => $token,
				'user_id' => $user->id
			], Response::HTTP_OK, trans('LOGIN_SUCCESSFUL'));
		}
		else {
			return Response()->json([
				'status' => false,
				'message' => current(current($validator->errors()->getMessages()))
			], Response::HTTP_OK);
		}

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
		$data = $request->validate([
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

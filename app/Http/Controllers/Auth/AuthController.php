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
use Illuminate\Support\Str;

class AuthController extends Controller {
	/**
	 * Register the user for matrimonial.
	 *
	 * @param  \Illuminate\Http\Request  $request
	 * @return \Illuminate\Http\JsonResponse
	 */
	public function register(Request $request)
	{
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
				$nameParts = explode(' ', $data['first_name']);
				$firstName = $nameParts[0];
				$lastName = implode(' ', array_slice($nameParts, 1));
				$data['first_name'] = ucfirst(strtolower($firstName));
				$data['last_name'] = ucfirst(strtolower($lastName));
				$data['token'] = General::hash();
				$user = Users::create($data);
				$verificationUrl = route('home', ['token' => $data['token']]);
				$codes = [
					'{name}' => $user->first_name . ' ' . $user->last_name,
					'{email}' => $user->email,
					'{url}' => General::urlToAnchor($verificationUrl)
				];
				$emails = [
					$data['email']
				];
				General::sendTemplateEmail($emails, 'registration', $codes);
				return response()->json([
					'message' => trans('REGISTER_SUCCESSFULL'),
					'email' => $user->email,
					'user_id' => $user->id
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
	public function login(Request $request)
	{
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
				return Response()->json([
					'status' => false,
					'message' => trans('EMAIL_IS_NOT_VERIFIED')
				], Response::HTTP_OK);
			}
			$token = $user->createToken($request->email)->plainTextToken;
			Users::whereEmail($data['email'])->update([
				'last_login_at' => Carbon::now()->timestamp,
				'last_login_ip' => $request->getClientIp(),
			]);
			return response()->json([
				'message' => trans('LOGIN_SUCCESSFUL'),
				'email' => $user->email,
				'user_id' => $user->id,
				'token' => $token,
			], Response::HTTP_OK);
		}
		else {
			return Response()->json([
				'status' => false,
				'message' => current(current($validator->errors()->getMessages()))
			], Response::HTTP_OK);
		}

	}

	function forgotPassword(Request $request)
    {
    	if($request->isMethod('post'))
    	{
			$data = $request->toArray();
			$validator = Validator::make(
				$data,
				[
					'email' => [
						'required', 'bail', 'string', 'max:255', 'email',
						Rule::exists(Users::class, 'email')
					]
				]
			);
			if(!$validator->fails())
			{
				$user = Users::where('email', $data['email'])->get();
				$user->token = General::hash();
				if($user->save()){
					$codes = [
						'{first_name}' => $user->first_name,
						'{last_name}' => $user->last_name,
						'{email}' => $user->email,
						'{recovery_link}' => url()->route('user.recoverPassword', ['hash' => $user->token])
					];

					General::sendTemplateEmail(
						$user->email, 
						'user-forgot-password',
						$codes
					);

					return Response()->json([
						'status' => true,
						'message' => 'We have sent you a recovery link on your email. Please follow the email.'
					], Response::HTTP_OK);	
				}	
				else
				{
					return Response()->json([
						'status' => false,
						'message' => 'Something went wrong. Please try again.'
					], Response::HTTP_OK);
				}
			}
			else {
				return Response()->json([
					'status' => false,
					'message' => current(current($validator->errors()->getMessages()))
				], Response::HTTP_OK);
			}
	    }
		return view('frontend.auth.forgotPassword');
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

	
    function recoverPassword(Request $request, $hash)
    {
    	$user = Users::getRow([
    			'token like ?' => [$hash]
    		]);
    	if($user)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
	            $validator = Validator::make(
		            $request->toArray(),
		            [
		                'new_password' => [
		                	'required',
						    'string',
							Password::min(8)->mixedCase()->numbers()->symbols()->uncompromised(), 'max:36'
		                ],
		                'confirm_password' => [
		                	'required',
						    'same:new_password'
		                ]
		            ]
		        );
		        if(!$validator->fails())
		        {
		        	unset($data['_token']);
	        			$user->password = $data['new_password'];
	        			if($user->save())
	        			{
							return Response()->json([
								'status' => true,
								'message' => 'Password updated successfully. Login with new credentials to proceed.'
							], Response::HTTP_OK);
	        			}
	        			else
	        			{
							return Response()->json([
								'status' => false,
								'message' => 'New password could be updated.'
							], Response::HTTP_OK);			
	        			}
			    }
			    else
			    {
					return Response()->json([
						'status' => false,
						'message' => current(current($validator->errors()->getMessages()))
					], Response::HTTP_OK);
			    }
			}
			return view("user/auth/recoverPassword");
		}
		else
		{
			abort(404);
		}
    }
}

<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\Privacy;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;

class OAuthController extends Controller {
	/**
	 * Redirect user to facebook for authentication.
	 */
	public function redirectToFacebook() {
		return Socialite::driver('facebook')->stateless()->redirect();
	}

	/**
	 * Get callback from facebook authentication.
	 *
	 * @return \Illuminate\Contracts\View\View|\Illuminate\Contracts\View\Factory
	 */
	public function callbackFomFacebook() {
		$user = Socialite::driver('facebook')->stateless()->user();

		$user_exists = User::whereEmail($user->getEmail())->whereIn('provider', ['google', 'matrimonial'])->exists();
		if ($user_exists) {
			return view('callback', ['status' => 'false', 'type' => 'facebook', 'message' => trans('validation.unique', ['attribute' => 'email']), 'token' => null, 'verified' => 'false']);
		}

		$user_data = User::whereProviderId($user->getId())->exists();
		if ($user_data) {
			$saveUser = tap(User::whereProviderId($user->getId()))->update([
				'avatar' => $user->getAvatar()
			])->first();
		} else {
			$saveUser = User::create([
				'id' => (string) Str::uuid(),
				'firstname' => $user->user['given_name'] ?? null,
				'lastname' => $user->user['family_name'] ?? null,
				'email' => $user->getEmail(),
				'email_verified_at' => Carbon::now()->timestamp,
				'avatar' => $user->getAvatar(),
				'provider' => 'google',
				'provider_id' => $user->getId(),
			]);
			$saveUser->refresh();
		}
		$saveUser = User::whereId($saveUser->id)->first();
		$verified = !$saveUser->phone_number_verified_at ? 'false' : 'true';
		$token = $saveUser->createToken($saveUser->id)->plainTextToken;
		Auth::loginUsingId($saveUser->id);
		$privacy = Privacy::whereUserId($saveUser->id)->exists();
		if (!$privacy) {
			Artisan::call('privacy:seed ' . $saveUser->id);
		}

		return view('callback', ['status' => 'true', 'type' => 'facebook', 'message' => 'success', 'token' => $token, 'verified' => $verified]);
	}

	/**
	 * Redirect user to google for authentication.
	 */
	public function redirectToGoogle() {
		return Socialite::driver('google')->stateless()->redirect();
	}

	/**
	 * Get callback from google authentication.
	 *
	 * @return \Illuminate\Contracts\View\View|\Illuminate\Contracts\View\Factory
	 */
	public function callbackFromGoogle() {
		$user = Socialite::driver('google')->stateless()->user();
		$user_exists = User::whereEmail($user->getEmail())->whereIn('provider', ['facebook', 'matrimonial'])->first();
		if ($user_exists) {
			return view('callback', ['status' => 'false', 'type' => 'google', 'message' => trans('validation.unique', ['attribute' => 'email']), 'token' => null, 'verified' => 'false']);
		}

		$user_data = User::whereProviderId($user->getId())->exists();
		if ($user_data) {
			$saveUser = tap(User::whereProviderId($user->getId()))->update([
				'avatar' => $user->getAvatar()
			])->first();
		} else {
			$saveUser = User::create([
				'id' => (string) Str::uuid(),
				'firstname' => $user->user['given_name'] ?? null,
				'lastname' => $user->user['family_name'] ?? null,
				'email' => $user->getEmail(),
				'email_verified_at' => Carbon::now()->timestamp,
				'avatar' => $user->getAvatar(),
				'provider' => 'google',
				'provider_id' => $user->getId(),
			]);
			$saveUser->refresh();
		}
		$saveUser = User::whereId($saveUser->id)->first();
		$verified = !$saveUser->phone_number_verified_at ? 'false' : 'true';
		$token = $saveUser->createToken($saveUser->id)->plainTextToken;
		Auth::loginUsingId($saveUser->id);
		$privacy = Privacy::whereUserId($saveUser->id)->exists();
		if (!$privacy) {
			Artisan::call('privacy:seed ' . $saveUser->id);
		}

		return view('callback', ['status' => 'true', 'type' => 'google', 'message' => 'success', 'token' => $token, 'verified' => $verified]);
	}
}

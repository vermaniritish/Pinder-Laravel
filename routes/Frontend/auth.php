<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\UserVerificationController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
	Route::prefix('resend')->middleware(['throttle:5,60'])->group(function () {
		Route::post('email-otp', [UserVerificationController::class, 'resendEmailVerificationOtp']);
		Route::post('phone-otp', [UserVerificationController::class, 'resendPhoneVerificationOtp']);
	});
	Route::prefix('verify')->middleware(['throttle:10,60'])->group(function () {
		Route::post('otp', [AuthController::class, 'verifyVerificationOtp']);
		Route::post('phone-otp', [AuthController::class, 'verifyPhoneVerificationOtp']);
	});
	Route::post('register', [AuthController::class, 'register']);
	Route::post('login', [AuthController::class, 'login'])->name('login');
	Route::get('logout', [AuthController::class, 'logout'])->name('logout');
	Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
	Route::post('update-password', [AuthController::class, 'updatePassword']);
	Route::get('/otp-verify/{hash}', [AuthController::class, 'otpVerify'])
    ->name('user.otpVerify');
	Route::post('/otp-verify/{hash}', [AuthController::class, 'otpVerify'])
		->name('user.otpVerify');
	Route::get('/recover-password/{hash}', [AuthController::class, 'recoverPassword'])
    ->name('user.recoverPassword');
	Route::post('/recover-password/{hash}', [AuthController::class, 'recoverPassword'])
		->name('user.recoverPassword');
});
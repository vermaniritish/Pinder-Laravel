<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\UserVerificationController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
	Route::middleware('auth:sanctum')->group(function () {
		Route::delete('logout', [AuthController::class, 'destroy']);
		Route::post('update_password', [AuthController::class, 'updatePassword']);
	});
	Route::prefix('resend')->middleware(['throttle:5,60'])->group(function () {
		Route::post('email-otp', [UserVerificationController::class, 'resendEmailVerificationOtp']);
		Route::post('phone-otp', [UserVerificationController::class, 'resendPhoneVerificationOtp']);
	});
	Route::prefix('verify')->middleware(['throttle:10,60'])->group(function () {
		Route::post('otp', [AuthController::class, 'verifyVerificationOtp']);
		Route::post('phone-otp', [AuthController::class, 'verifyPhoneVerificationOtp']);
	});
	Route::post('register', [AuthController::class, 'register']);
	Route::get('register', [AuthController::class, 'register']);
	Route::post('login', [AuthController::class, 'login'])->name('login');
	Route::post('forgot-password', [AuthController::class, 'forgotPassword']);
	Route::get('/recover-password/{hash}', [AuthController::class, 'recoverPassword'])
    ->name('admin.recoverPassword');
	Route::post('/recover-password/{hash}', [AuthController::class, 'recoverPassword'])
		->name('admin.recoverPassword');
});
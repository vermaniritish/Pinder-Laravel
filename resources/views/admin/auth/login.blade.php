@extends('layouts.adminloginlayout')
@section('content')
	<!-- Header -->
	<div class="header bg-gradient-warning py-7 py-lg-7 pt-lg-8">
		<div class="container">
			<div class="header-body text-center mb-7">
				<div class="row justify-content-center">
					<div class="col-xl-5 col-lg-6 col-md-8 px-5">
						<h1 class="text-white">Welcome!</h1>
					</div>
				</div>
			</div>
		</div>
		<div class="separator separator-bottom separator-skew zindex-100">
			<svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1" xmlns="http://www.w3.org/2000/svg">
				<polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
			</svg>
		</div>
	</div>
	<!-- Page content -->
	<div class="container mt--8 pb-5">
		<div class="row justify-content-center">
			<div class="col-lg-5 col-md-7">
				<div class="card bg-secondary border-0 mb-0">
					<div class="card-header bg-transparent pb-3">
						<div class="text-center mt-2 mb-3"><h2 class="text-dark">Sign in with credentails</h2></div>
					</div>
					<div class="card-body px-lg-5 py-lg-5">
						<!--!! FLAST MESSAGES !!-->
						@include('admin.partials.flash_messages')
						<form method="post" role="form" id="sign_in" action="<?php echo route('admin.login') ?>">
							<!--!! CSRF FIELD !!-->
							{{ csrf_field() }}

							<?php if(isset($recaptchaEnabled) && $recaptchaEnabled): ?>
								<input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response">
							<?php endif; ?>
							<div class="form-group mb-3">
								<div class="input-group input-group-merge input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-email-83"></i></span>
									</div>
									<input class="form-control" required placeholder="Email" type="email" name="email" value="{{ old('email') }}">
								</div>
								@error('email')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<div class="input-group input-group-merge input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
									</div>
									<input class="form-control" required placeholder="Password" type="password" name="password" value="{{ old('password') }}">
								</div>
								@error('password')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="custom-control text-right">
								<a href="<?php echo route('admin.forgotPassword') ?>" class="text-dark"><small>Forgot password?</small></a>
							</div>
							<div class="text-center">
						    	<button type="submit" class="btn btn-primary my-4">Sign in</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
@endsection
@extends('layouts.adminloginlayout')
@section('content')
	<!-- Header -->
	<div class="header bg-gradient-warning py-7 py-lg-7 pt-lg-8">
		<div class="container">
			<div class="header-body text-center mb-7">
				<div class="row justify-content-center">
					<div class="col-xl-5 col-lg-6 col-md-8 px-5">
						<h1 class="text-white">Second Factor Authentication?</h1>
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
						<div class="text-center mt-2 mb-3"><h2 class="text-dark">Enter one time password to login.</h2></div>
					</div>
					<div class="card-body px-lg-5 py-lg-5">
						<!--!! FLAST MESSAGES !!-->
						@include('admin.partials.flash_messages')
						<form method="post" role="form" id="forgot_password">
							<!--!! CSRF FIELD !!-->
							{{ csrf_field() }}
							<div class="form-group mb-3">
								<div class="input-group input-group-merge input-group-alternative">
									<div class="input-group-prepend">
										<span class="input-group-text"><i class="ni ni-email-83"></i></span>
									</div>
									<input class="form-control" required placeholder="OTP" type="text" name="otp" value="{{ old('otp') }}">
								</div>
								@error('otp')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="text-center">
						    	<button type="submit" class="btn btn-primary my-4">Submit</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
@endsection
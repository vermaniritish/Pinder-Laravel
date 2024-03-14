@extends('layouts.adminloginlayout')
@section('content')
	<!-- Header -->
	<div class="header bg-gradient-warning py-7 py-lg-7 pt-lg-8">
		<div class="container">
			<div class="header-body text-center mb-7">
				<div class="row justify-content-center">
					<div class="col-xl-5 col-lg-6 col-md-8 px-5">
						<h1 class="text-white">Recover Password!</h1>
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
			<div class="col-lg-6 col-md-8">
				<div class="card bg-secondary border-0 mb-0">
					<div class="card-header bg-transparent pb-3">
						<div class="text-center mt-2 mb-3"><h2 class="text-dark">Create new password for account.</h2></div>
					</div>
					<div class="card-body px-lg-5 py-lg-5">
						<!--!! FLAST MESSAGES !!-->
						@include('admin.partials.flash_messages')
						<form method="post" role="form" id="recover-password">
							<!--!! CSRF FIELD !!-->
							{{ csrf_field() }}
							<div class="col-lg-12">
								<div class="form-group passwordGroup">
									<label>New Password</label>
									<div class="input-group">
										<input type="password" class="form-control" name="new_password" placeholder="*****" aria-label="" aria-describedby="button-addon4" name="password" required>
										<div class="input-group-append" id="button-addon4">
											<button class="btn btn-outline-primary viewPassword" type="button"><i class="fas fa-eye"></i></button>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="form-group passwordGroup">
									<label>Confirm Password</label>
									<div class="input-group">
										<input type="password" class="form-control" name="confirm_password" placeholder="******" aria-label="" aria-describedby="button-addon4" name="password" required>
										<div class="input-group-append" id="button-addon4">
											<button class="btn btn-outline-primary viewPassword" type="button"><i class="fas fa-eye"></i></button>
										</div>
									</div>
								</div>
								<div class="form-group">
									<small class="text-info">Password must be minimum 8 characters long.<br></small>
									<small class="text-info">Password should contain at least one capital letter (A-Z), one small letter (a-z), one number (0-9) and one special character (!@#$%^&amp;*).</small>
								</div>
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
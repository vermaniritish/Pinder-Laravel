@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Change Password</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="#" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<form method="post" action="<?php echo route('admin.changePassword') ?>" id="change_password"">
	<!--!! CSRF FIELD !!-->
	{{ @csrf_field() }}
		<div class="row">
			<div class="col-xl-8 order-xl-1">
				<div class="card">
					<!--!! FLAST MESSAGES !!-->
					@include('admin.partials.flash_messages')
					
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-8">
								<h3 class="mb-0">Enter Your Password Here.</h3>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group passwordGroup">
										<label>Old Password</label>
										<div class="input-group">
											<input type="password" class="form-control" name="old_password" placeholder="******" aria-label="" aria-describedby="button-addon4" name="password" required>
											<div class="input-group-append" id="button-addon4">
												<button class="btn btn-outline-primary viewPassword" type="button"><i class="fas fa-eye"></i></button>
											</div>
										</div>
									</div>
								</div>
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
							</div>
						</div>
						<hr class="my-4" />
						<button class="btn btn-sm py-2 px-3 btn-primary float-right">
							<i class="fa fa-save"></i> Submit
						</button>
					</div>
				</div>
			</div>
			<div class="col-xl-4 order-xl-1">
				@include("admin.profile.profile")
			</div>
		</div>
	</form>
</div>
@endsection
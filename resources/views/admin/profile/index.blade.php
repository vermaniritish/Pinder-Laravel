@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">My Profile</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<form method="post" action="<?php echo route('admin.profile') ?>">
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
								<h3 class="mb-0">Create New Admin Here.</h3>
							</div>
						</div>
					</div>
					<div class="card-body">					
						<h6 class="heading-small text-muted mb-4">User information</h6>
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">First name</label>
										<input type="text" class="form-control" name="first_name" required placeholder="First name" value="<?php echo $admin->first_name ?>">
										@error('first_name')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>

								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-last-name">Last name</label>
										<input type="text" id="input-last-name" class="form-control" placeholder="Last name" name="last_name" value="<?php echo $admin->last_name ?>">
										@error('last_name')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-username">Email Address</label>
										<input type="email" id="input-username" class="form-control" placeholder="info@example.com" name="email"  value="<?php echo $admin->email ?>">
										@error('email')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-lg-6">
									<div class="form-group">
										<label class="form-control-label" for="input-email">Phone Number</label>
										<input type="text" id="input-email" class="form-control" placeholder="9988774455" name="phonenumber"  value="<?php echo $admin->phonenumber ?>">
										@error('phonenumber')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12">
									<div class="form-group">
										<label>Address</label>
										<textarea rows="2" class="form-control" placeholder="Your address" name="address"><?php echo $admin->address ?></textarea>
										@error('address')
										    <small class="text-danger">{{ $message }}</small>
										@enderror
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
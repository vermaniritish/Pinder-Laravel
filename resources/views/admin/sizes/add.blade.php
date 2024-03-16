@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Size</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="<?php echo route('admin.size') ?>" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div class="row">
		<div class="col-xl-12 order-xl-1">
			<!--!! FLAST MESSAGES !!-->
			@include('admin.partials.flash_messages')
			<div class="card">
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.size.add') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<h6 class="heading-small text-muted mb-4">Men Size information</h6>
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Size Type</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">From cm</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">To cm</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Chest</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Waist</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Hip</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Length</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
						</div>
						<hr class="my-4" />
						<button href="#" class="btn btn-sm py-2 px-3 btn-primary float-right">
							<i class="fa fa-save"></i> Submit
						</button>
					</form>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.size.add') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<h6 class="heading-small text-muted mb-4">Women Size information</h6>
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Size Type</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">From cm</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">To cm</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Chest</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Waist</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Hip</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Length</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
						</div>
						<hr class="my-4" />
						<button href="#" class="btn btn-sm py-2 px-3 btn-primary float-right">
							<i class="fa fa-save"></i> Submit
						</button>
					</form>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.size.add') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<h6 class="heading-small text-muted mb-4">Unisex Size information</h6>
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Size Type</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">From cm</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">To cm</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Chest</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Waist</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Hip</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
								<div class="col-md-2">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Length</label>
										<input type="text" class="form-control" name="color_code" required placeholder="Colour Code" value="{{ old('color_code') }}">
										@error('color_code')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
						</div>
						<hr class="my-4" />
						<button href="#" class="btn btn-sm py-2 px-3 btn-primary float-right">
							<i class="fa fa-save"></i> Submit
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection
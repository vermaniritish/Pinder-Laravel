@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Rating</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="<?php echo route('admin.ratings') ?>" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div class="row">
		<div class="col-xl-12 order-xl-1">
			<div class="card">
				<!--!! FLAST MESSAGES !!-->
				@include('admin.partials.flash_messages')
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col-8">
							<h3 class="mb-0">Create New Rating Here.</h3>
						</div>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.ratings.edit',['id' => $page->id]) ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<h6 class="heading-small text-muted mb-4">Rating information</h6>
						<div class="pl-lg-4">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-control-label" for="input-first-name">Name</label>
									<input type="text" class="form-control" name="name" required placeholder="Name" value="{{ old('name',$page->name) }}">
									@error('name')
										<small class="text-danger">{{ $message }}</small>
									@enderror
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-control-label" for="input-first-name">Designation</label>
									<input type="text" class="form-control" name="designation" placeholder="Designation" value="{{ old('designation',$page->designation) }}">
									@error('designation')
										<small class="text-danger">{{ $message }}</small>
									@enderror
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-control-label" for="input-first-name">Rating</label>
									<input type="text" class="form-control" name="rating" required placeholder="Designation" value="{{ old('rating',$page->rating) }}">
									@error('designation')
										<small class="text-danger">{{ $message }}</small>
									@enderror
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
								<label class="form-control-label" for="input-first-name">Image (on/off)</label>
									<div class="custom-control mt-2">
										<label class="custom-toggle">
											<input type="checkbox" name="image_status" value="1"
												<?php echo old('image_status', $page->image_status) ? 'checked' : ''; ?>>
											<span class="custom-toggle-slider rounded-circle"
												data-label-off="No" data-label-on="Yes"></span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label class="form-control-label">Message</label>
									<textarea required rows="2" id="editor1" class="form-control" placeholder="Message" required name="message">{{ old('message',$page->message) }}</textarea>
									@error('message')
										<small class="text-danger">{{ $message }}</small>
									@enderror
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
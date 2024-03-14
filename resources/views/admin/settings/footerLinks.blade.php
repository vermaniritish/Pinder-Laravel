<?php use App\Models\Admin\Settings; ?>
@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Footer Settings</h6>

				</div>
			</div>
			@include('admin.partials.flash_messages')
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div class="row">
		<div class="col-xl-6 order-xl-1">
			<div class="card">
				<!--!! FLAST MESSAGES !!-->
				
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col-8">
							<h3 class="mb-0">General Settings</h3>
						</div>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.settings.footerLinks') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<div class="pl-lg-4">
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Blog</label>
								<input type="text" class="form-control" name="blog_link" required placeholder="http://example.com/blog" value="{{ Settings::get('blog_link') }}">
								@error('blog_link')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Support</label>
								<input type="text" class="form-control" name="support_link" required placeholder="http://example.com/support" value="{{ Settings::get('support_link') }}">
								@error('support_link')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Privacy Policy</label>
								<input type="text" class="form-control" name="privacy_policy_link" required placeholder="http://example.com/privacy-policy" value="{{ Settings::get('privacy_policy_link') }}">
								@error('privacy_policy_link')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Terms of Service</label>
								<input type="text" class="form-control" name="terms_of_service_link" required placeholder="http://example.com/terms-of-service" value="{{ Settings::get('terms_of_service_link') }}">
								@error('terms_of_service_link')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
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
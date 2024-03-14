<?php use App\Models\Admin\Settings; ?>
@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Home Page</h6>

				</div>
			</div>
			@include('admin.partials.flash_messages')
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div class="row">
		<div class="col-xl-8 order-xl-1">
			<div class="card">
				<!--!! FLAST MESSAGES !!-->
				
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col-8">
							<h3 class="mb-0">Page Information</h3>
						</div>
					</div>
				</div>
				<div class="card-body">
					<form method="post" action="<?php echo route('admin.settings.home') ?>" class="form-validation">
						<!--!! CSRF FIELD !!-->
						{{ @csrf_field() }}
						<div class="pl-lg-4">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" id="center" name="home_page_layout" value="center" {{ Settings::get('home_page_layout') == 'center' ? 'checked' : '' }} class="custom-control-input">
											<label class="custom-control-label" for="center">Center Layout</label>
										</div>
										<div class="custom-control custom-radio custom-control-inline">
											<input type="radio" id="banner" name="home_page_layout" value="banner" {{ Settings::get('home_page_layout') == 'banner' ? 'checked' : '' }} class="custom-control-input">
											<label class="custom-control-label" for="banner">Banner Layout</label>
										</div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Tag Line</label>
								<input type="text" class="form-control" name="home_page_text" required placeholder="Title" value="{{ Settings::get('home_page_text') }}">
								@error('home_page_text')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Search Title</label>
								<input type="text" class="form-control" name="home_page_search_text" required placeholder="Title" value="{{ Settings::get('home_page_search_text') }}">
								@error('home_page_search_text')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="row">
								<div class="col-md-6">
									<label class="form-control-label" for="input-first-name">Banner</label>
									<div 
										class="upload-image-section"
										data-type="image"
										data-multiple="false"
										data-path="logos"
									>
										<div class="upload-section">
											<div class="button-ref mb-3">
												<button class="btn btn-icon btn-primary btn-lg" type="button">
									                <span class="btn-inner--icon"><i class="fas fa-upload"></i></span>
									                <span class="btn-inner--text">Upload Image</span>
								              	</button>
								              	<p><small>Recommend Size: 612px * 378px</small></p>
								            </div>
								            <!-- PROGRESS BAR -->
											<div class="progress d-none">
							                  <div class="progress-bar bg-default" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
							                </div>
							            </div>
						                <!-- INPUT WITH FILE URL -->
						                <textarea class="d-none" name="home_page_banner"></textarea>
						                <div class="show-section <?php echo !old('home_page_banner') ? 'd-none' : "" ?>">
						                	@include('admin.partials.previewFileRender', ['file' => old('home_page_banner') ])
						                </div>
						                <div class="fixed-edit-section">
						                	@include('admin.partials.previewFileRender', ['file' => Settings::get('home_page_banner'), 'relationType' => 'settings.home_page_banner', 'relationId' => "" ])
						                </div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label class="form-control-label" for="input-first-name">Sugessions</label>
										<div class="custom-control">
											<label class="custom-toggle">
												<input type="hidden" name="home_page_search_sugession" value="0">
												<input type="checkbox" name="home_page_search_sugession" value="1" {{ Settings::get('home_page_search_sugession') ? 'checked' : '' }} id="enableSugessions">
												<span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>
											</label>
											<label class="custom-control-label">Enable Suggessions?</label>
										</div>
									</div>
								</div>
							</div>
							<hr class="my-4" />
							<!-- Address -->
							<h6 class="heading-small text-muted mb-4">Ignore Keywords</h6>
							<div class="form-group">
								<label class="form-control-label" for="input-first-name">Enter the keywords to ignore for search.</label>
								<input type="text" class="form-control tag-it-capital" name="ignore_keywords" placeholder="Tags" value="{{ Settings::get('ignore_keywords') }}">
								@error('ignore_keywords')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<hr class="my-4" />
							<!-- Mission -->
							<h6 class="heading-small text-muted mb-4">Mission Title</h6>
							<div class="form-group">
								<label class="form-control-label" for="input-mission_title">Mission Title</label>
								<input type="text" class="form-control" name="mission_title" required placeholder="Mission Title" value="{{ Settings::get('mission_title') }}">
								@error('mission_title')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<h6 class="heading-small text-muted mb-4">Mission Description</h6>
							<div class="form-group">
								<label class="form-control-label" for="input-mission_description">Mission Description</label>
								<input type="text" class="form-control" name="mission_description" required placeholder="Mission Description" value="{{ Settings::get('mission_description') }}">
								@error('mission_description')
								    <small class="text-danger">{{ $message }}</small>
								@enderror
							</div>
							<div class="row">
								<div class="col-md-6">
									<label class="form-control-label" for="input-first-name">Mission Image</label>
									<div 
										class="upload-image-section"
										data-type="image"
										data-multiple="false"
										data-path="mission"
									>
										<div class="upload-section">
											<div class="button-ref mb-3">
												<button class="btn btn-icon btn-primary btn-lg" type="button">
									                <span class="btn-inner--icon"><i class="fas fa-upload"></i></span>
									                <span class="btn-inner--text">Upload Image</span>
								              	</button>
								              	<p><small>Recommend Size: 545px * 428px</small></p>
								            </div>
								            <!-- PROGRESS BAR -->
											<div class="progress d-none">
							                  <div class="progress-bar bg-default" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
							                </div>
							            </div>
						                <!-- INPUT WITH FILE URL -->
						                <textarea class="d-none" name="mission_image"></textarea>
						                <div class="show-section <?php echo !old('mission_image') ? 'd-none' : "" ?>">
						                	@include('admin.partials.previewFileRender', ['file' => old('mission_image') ])
						                </div>
						                <div class="fixed-edit-section">
						                	@include('admin.partials.previewFileRender', ['file' => Settings::get('mission_image'), 'relationType' => 'settings.mission_image', 'relationId' => "" ])
						                </div>
									</div>
								</div>
							</div>
						</div>
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
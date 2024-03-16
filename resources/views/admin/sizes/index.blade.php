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
					@include('admin.sizes.filters')
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
		@if (isset($male))
			<pre id="male" class="d-none">{{ $male }}</pre>
		@endif
		@if (isset($female))
			<pre id="female" class="d-none">{{ $female }}</pre>
		@endif
		@if (isset($unisex))
			<pre id="unisex" class="d-none">{{ $unisex }}</pre>
		@endif
			<!--!! FLAST MESSAGES !!-->
			@include('admin.partials.flash_messages')
			@include('admin.sizes.men')
			@include('admin.sizes.women')
			@include('admin.sizes.unisex')
		</div>
	</div>
</div>
@endsection
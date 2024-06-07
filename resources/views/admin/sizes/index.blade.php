@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center pt-4 pb-2">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Size</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
				</div>
			</div>
			<div class="row align-items-center pb-4 pl-3">
				<a href="<?php echo route('admin.size.slug', ['slug' => 'men']) ?>" class="btn {{ !$slug || $slug == 'men' ? 'btn-primary' : 'btn-neutral' }}">Men</a>
				<a href="<?php echo route('admin.size.slug', ['slug' => 'women']) ?>" class="btn {{ $slug == 'women' ? 'btn-primary' : 'btn-neutral' }}">Women</a>
				<a href="<?php echo route('admin.size.slug', ['slug' => 'unisex']) ?>" class="btn {{ $slug == 'unisex' ? 'btn-primary' : 'btn-neutral' }}">Unisex</a>
				<a href="<?php echo route('admin.size.slug', ['slug' => 'kids']) ?>" class="btn {{ $slug == 'kids' ? 'btn-primary' : 'btn-neutral' }}">Kids</a>
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
		@if (isset($kids))
			<pre id="kids" class="d-none">{{ $kids }}</pre>
		@endif
			<!--!! FLAST MESSAGES !!-->
			@include('admin.partials.flash_messages')
			@if($slug == 'men')
			@include('admin.sizes.men')
			@endif
			@if($slug == 'women')
			@include('admin.sizes.women')
			@endif
			@if($slug == 'unisex')
			@include('admin.sizes.unisex')
			@endif
			@if($slug == 'kids')
			@include('admin.sizes.kids')
			@endif
		</div>
	</div>
</div>
@endsection
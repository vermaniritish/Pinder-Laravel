@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center py-4">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Products</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
					<a href="<?php echo route('admin.products') ?>" class="btn btn-neutral"><i class="ni ni-bold-left"></i> Back</a>
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
							<h3 class="mb-0">Create New Product Here.</h3>
						</div>
					</div>
				</div>
				<div class="card-body">
					<div id="product" >
						<p v-if="mounting" class="text-center big" style="padding: 15%"><i style="font-size: 30px" class="fa fa-spin fa-spinner"></i></p>
						<form id="product-form" method="post" action="<?php echo route('admin.products.add') ?>" class="form-validation d-none">
							@if (isset($product) && $product->id)
								<pre id="edit-form" class="d-none">{{ $product }}</pre>
							@endif
							<pre id="availableColor" class="d-none">{{ $colors }}</pre>
							<!--!! CSRF FIELD !!-->
							{{ @csrf_field() }}
							<h6 class="heading-small text-muted mb-4">Product information</h6>
							<div class="pl-lg-4">
								<div id="sub-category-form" class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-control-label" for="input-first-name">Category</label>
											<select v-model="selectedCategory" class="no-selectpicker form-control" name="category" required>
											<?php foreach($categories as $c): ?>
												<option 
													value="<?php echo $c->id ?>" 
													<?php echo old('category') && in_array($c->id, old('category'))  ? 'selected' : '' ?> 
												><?php echo $c->title ?></option>
											<?php endforeach; ?>
											</select>
											@error('category')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-control-label" for="input-first-name">Sub Category</label>
											<select class="form-control no-selectpicker" v-model="selectedSubCategory" name="sub_category[]" required multiple>
												<option v-for="subCategory in subCategories" :key="subCategory.id" :value="subCategory.id">
													@{{ subCategory.title }}
												</option>
											</select>
											@error('category')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="form-control-label" for="input-first-name">Title</label>
									<input type="text" v-model="title" class="form-control" name="title" placeholder="Title" required value="{{ old('title') }}">
									@error('title')
										<small class="text-danger">{{ $message }}</small>
									@enderror
								</div>
								<div class="row">
									<div class="col-lg-12">
										<div class="form-group">
											<label class="form-control-label">Description</label>
											<textarea v-model="description" rows="2" id="product-editor" class="form-control" placeholder="Description" name="description">{{ old('description') }}</textarea>
											@error('description')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label class="form-control-label">Color</label>
											<select class="form-control no-selectpicker" v-on:change="updateSelectedColor" v-model="selectedColor" name="color_id[]" multiple required>
												<option value="">Select</option>
												<?php 
													foreach($colors as $s): 
													$content = $s->title . ' (' . $s->color_code . ')';
												?>
												<option 
													value="<?php echo $s->id ?>" 
													<?php echo old('color_id') == $s->id  ? 'selected' : '' ?>
													data-content="<?php echo $content ?>"
												>
													<?php echo $s->name; ?>		
												</option>
												<?php endforeach; ?>
											</select>
											@error('colr_id')
											<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label class="form-control-label" for="input-username">Gender Specific To ?</label>
											<select v-model="selectedGender" required class="form-control no-selectpicker" name="gender">
												<option {{ old('gender') == 'Male' ? 'selected' : '' }}
													value="Male"> Male</option>
												<option {{ old('gender') == 'Female' ? 'selected' : '' }}
													value="Female"> Female</option>
												<option {{ old('gender') == 'Kids' ? 'selected' : '' }}
													value="Kids"> Kids</option>
												<option {{ old('gender') == 'Unisex' ? 'selected' : '' }}
													value="Unisex"> Unisex</option>
											</select>
											@error('gender')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label class="form-control-label" for="input-first-name">Price</label>
											<input type="number" min="0" class="form-control" v-model="price" name="price" placeholder="Price" required value="{{ old('price') }}">
											@error('price')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<label class="form-control-label" for="input-first-name">Max Price</label>
											<input type="number" class="form-control" v-model="maxPrice" name="max_price" <?php echo (old('status')) ?> placeholder="Max Price" value="{{ old('max_price') }}">
											@error('max_price')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
								</div>
								<div id="size-form" class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label class="form-control-label" for="input-username">Brand</label>
											<select v-model="selectedBrand" class="form-control no-selectpicker" name="brand[]" required multiple>
												@foreach ($brands as $key => $value)
												<option <?php echo (is_array(old('brand')) && in_array($value['id'], old('brand'))) ? 'selected' : ''; ?>
													value="<?php echo $value['id']; ?>"><?php echo $value['title']; ?></option>
												@endforeach
											</select>
											@error('brand')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
								</div>
								<div v-for="(colorSelectedId, colorIndex) in selectedColor" :key="colorIndex">
									<div class="row">		
										<div class="col-md-4">
											<div class="form-group">
												<label>Select Size For 
													<span v-for="color in availableColors" 
														v-if="Number(color.id) === Number(colorSelectedId)" 
														:style="{ backgroundColor: color.color_code }" class="badge badge-secondary">@{{ color.title }}
													</span>
												</label>
												<select class="form-control size-select no-selectpicker" v-on:change="updateSelectedSize" v-model="selectedSizeIds[colorSelectedId]" multiple required>
													<option value="">Select</option>
													<option v-for="size in sizes" :value="size.id">
														@{{ size.size_title }} (@{{ size.from_cm }} - @{{ size.to_cm }} cm)
													</option>
												</select>
												<small class="text-danger"></small>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table align-items-center table-flush view-table">
											<thead>
												<tr>
													<th>#</th>
													<th>Size Title</th>
													<th>Size (From - To)</th>
													<th>Price</th>
													<th>Remove Item</th>
												</tr>
											</thead>
											<tbody>
												<tr v-for="(size, sizeIndex) in selectedSizeIds[colorSelectedId]" :key="sizeIndex">
													<td>@{{ sizeIndex + 1 }}</td>
													<td>@{{ size.size_title }}</td>
													<td>@{{ size.from_cm }} - @{{ size.to_cm }} cm</td>
													<td><input type="number"  min="0"></td>
													<td><i class="fa fa-times" @click="removeSize(colorSelectedId, sizeIndex)"></i></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<hr class="my-4" />
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<label class="form-control-label" for="input-tags">Tag</label>
											<input type="text" class="form-control tag" name="tags" v-model="tags" placeholder="Enter tags here." value="{{ old('tags') }}">
											@error('tags.*')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
								</div>	
							</div>
							<hr class="my-4" />
							<!-- Address -->
							<h6 class="heading-small text-muted mb-4">Publish Information</h6>
							<div class="pl-lg-4">
								<div class="row">
									<div class="col-lg-6">
										<div class="form-group">
											<!-- FILE OR IMAGE UPLOAD. FOLDER PATH SET HERE in data-path AND CHANGE THE data-multiple TO TRUE SEE MAGIC  -->
											<div 
												class="upload-image-section"
												data-type="image"
												data-multiple="true"
												data-path="products"
												data-resize-large="580*630"
												data-resize-small="282*310"

											>
												<div class="upload-section">
													<div class="button-ref mb-3">
														<button class="btn btn-icon btn-primary btn-lg" type="button">
															<span class="btn-inner--icon"><i class="fas fa-upload"></i></span>
															<span class="btn-inner--text">Upload Image</span>
															</button>
														<p><small>Recommend Size: 580*630</small></p>
													</div>
													<!-- PROGRESS BAR -->
													<div class="progress d-none">
														<div class="progress-bar bg-default" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
													</div>
												</div>
												<!-- INPUT WITH FILE URL -->
												<textarea class="d-none" required name="image"><?php echo old('image') ?></textarea>
												<div class="show-section <?php echo !old('image') ? 'd-none' : "" ?>">
													@include('admin.partials.previewFileRender', ['file' => old('image') ])
												</div>
											</div>
											@error('image')
												<small class="text-danger">{{ $message }}</small>
											@enderror
										</div>
									</div>
									<div class="col-lg-6">
										<div class="form-group">
											<div class="custom-control">
												<label class="custom-toggle">
													<input type="hidden" name="status" value="0">
													<input type="checkbox" name="status" value="1" <?php echo (old('status') != '0' ? 'checked' : '') ?>>
													<span class="custom-toggle-slider rounded-circle" data-label-off="No" data-label-on="Yes"></span>
												</label>
												<label class="custom-control-label">Do you want to publish this product ?</label>
											</div>
										</div>
									</div>
								</div>
							</div>
							<hr class="my-4" />
							<button type="button" class="btn btn-primary finish-steps float-right"
									v-on:click="submitForm()"><i class="fa fa-spin fa-spinner" v-if="loading"></i><i v-else
									class="fa fa-save"></i> Save 
							</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection
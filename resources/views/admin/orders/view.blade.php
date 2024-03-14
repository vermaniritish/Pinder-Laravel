@extends('layouts.adminlayout')
@section('content')
<?php

use App\Models\Admin\Permissions;
use App\Models\Admin\Settings;
	$currency = Settings::get('currency_symbol'); 
?>
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Manage Orders</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
						<a href="<?php echo route('admin.orders') ?>" class="btn btn-neutral"><i class="fa fa-arrow-left"></i> Back</a>
						<a href="#" class="btn btn-neutral" target="_blank"><i class="fa fa-eye"></i> View Page</a>
						<?php if(Permissions::hasPermission('orders', 'update') || Permissions::hasPermission('orders', 'delete')): ?>
							<div class="dropdown" data-toggle="tooltip" data-title="More Actions">
								<a class="btn btn-neutral" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="fas fa-ellipsis-v"></i>
								</a>
								<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
									<?php if(Permissions::hasPermission('orders', 'update')): ?>
										<a class="dropdown-item" href="<?php echo route('admin.orders.edit', ['id' => $page->id]) ?>">
											<i class="fas fa-pencil-alt text-info"></i>
											<span class="status">Edit</span>
										</a>
										<?php endif; ?>
									<?php if(Permissions::hasPermission('orders', 'delete')): ?>
										<div class="dropdown-divider"></div>
										<a 
											class="dropdown-item _delete" 
											href="javascript:;"
											data-link="<?php echo route('admin.orders.delete', ['id' => $page->id]) ?>"
										>
											<i class="fas fa-times text-danger"></i>
											<span class="status text-danger">Delete</span>
										</a>
									<?php endif; ?>
								</div>
							</div>
						<?php endif; ?>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Page content -->
	<div class="container-fluid mt--6">
		<div class="row">
			<div class="col-xl-7 order-xl-1">
				<div class="card">
					<!--!! FLAST MESSAGES !!-->
					@include('admin.partials.flash_messages')
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-8">
								<h3 class="mb-0">Order Information</h3>
							</div>
						</div>
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<!-- Projects table -->
							<table class="table align-items-center table-flush">
								<tbody>
									<tr>
										<th>Id</th>
										<td><?php echo $page->id ?></td>
									</tr>
									<tr>
										<th>Customer Name</th>
										<td>
											<?php echo $page->customer_name ?? 'N/A'; ?>
											<?php echo $page->customer ? ' - ' . $page->customer->phonenumber : ''; ?>
										</td>
									</tr>
									<tr>
										<th>Address</th>
										<td>
										<?php echo implode(', ', array_filter([$page->address])); ?>
										<br />
										<?php if($page->latitude && $page->longitude): ?>
										<a href="https://maps.google.com/maps?q={{$page->latitude}},{{$page->longitude }}&z=17&hl=en">Click to see location {{$page->latitude}} {{$page->longitude }}</a>
										<br /><small>Right click and "Copy link url" to share the location with staff.</small>
										<?php endif; ?>
										</td>
									</tr>
									<tr>
										<th>Booking Date</th>
										<td class="editable" id="booking-date">
										<span class="fill-text dotted-border">{{ _d($page->booking_date) }}<i class="fas fa-pencil text-primary edit-icon" onclick="enableEdit('booking-date', '<?php echo $page->booking_date; ?>')"></i></span>
											<div class="row d-none edit with-icon">
												<div class="col-md-6">
													<input type="date" name="booking_date" id="booking_date" class="form-control" value="<?php echo _d($page->booking_date) ?>"/>
												</div>
												<div class="col-md-6 p-0">
													<div class="row">
														<i class="fas fa-times text-primary times ml-2" onclick="exitEditMode('booking-date')"></i>
													</div>
													<div class="row">
														<i class="fa fa-save text-primary save-icon mt-3 ml-2" onclick="saveEdit('booking-date', 'booking_date', '<?php echo $page->id ?>')"></i>
													</div>
												</div>
											</div>
										</td> 
									</tr>
									<tr>
										<th>Booking Time</th>
										<td class="editable" id="booking-time">
											<span class="fill-text dotted-border">{{_time($page->booking_time)}}<i class="fas fa-pencil text-primary edit-icon" onclick="enableEdit('booking-time', '<?php echo $page->booking_time; ?>')"></i></span>
											<div class="row d-none edit with-icon">
												<div class="col-md-6">
													<input type="time" name="booking_time" id="booking_time" class="form-control" value="<?php echo _time($page->booking_time) ?>"/>
												</div>
												<div class="col-md-6 p-0">
													<div class="row">
														<i class="fas fa-times text-primary times ml-2" onclick="exitEditMode('booking-time')"></i>
													</div>
													<div class="row">
														<i class="fa fa-save text-primary save-icon mt-3 ml-2" onclick="saveEdit('booking-time', 'booking_time', '<?php echo $page->id ?>')"></i>
													</div>
												</div>
											</div>
										</td> 
									</tr>
									<!-- <tr>
										<th>Payment Type</th>
										<td><?php echo ($page->payment_type) ?></td>
									</tr> -->
									<tr>
										<th>Status</th>
										<td>	
											<div class="dropdown">
												<?php $statusData = $status[$page->status] ?? null; ?>
												<?php if ($statusData): ?>
													<button class="btn btn-sm dropdown-toggle" style="<?php echo $statusData['styles']; ?>"
															type="button" id="statusDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
															data-toggle="tooltip" title="{{ $page->statusBy ? ($page->statusBy->first_name . ($page->statusBy->last_name ? ' ' . $page->statusBy->last_name : '')) : null }}">
														{{ $statusData['label'] }}
													</button>
													<input type="hidden" id="Currentstatus" value={{ $page->status }} >
													<div class="dropdown-menu dropdown-menu-left" aria-labelledby="statusDropdown">
														<?php $switchUrl = route('admin.order.switchStatus', ['field' => 'status', 'id' => $page->id]); ?>
														<?php foreach ($status as $statusKey => $statusData): ?>
															<?php
																$badgeClass = '';
																switch ($statusKey) {
																	case 'pending':
																		$badgeClass = 'bg-danger';
																		break;
																	case 'accepted':
																		$badgeClass = 'bg-info';
																		break;
																	case 'on_the_way':
																		$badgeClass = 'bg-light';
																		break;
																	case 'reached_at_location':
																		$badgeClass = 'bg-dark';
																		break;
																	case 'in_progress':
																		$badgeClass = 'bg-warning';
																		break;
																	case 'completed':
																		$badgeClass = 'bg-success';
																		break;
																	case 'cancel':
																		$badgeClass = 'bg-danger';
																		break;
																	default:
																		$badgeClass = 'bg-secondary';
																		break;
																}
															?>
															<a class="dropdown-item" href="javascript:;" data-value="<?php echo $statusKey; ?>" 
																onclick="switch_diary_page_action('<?php echo $switchUrl; ?>', this)"
															>
															<span class="badge badge-dot mr-4">
																<i class="<?php echo $badgeClass; ?>"></i>
																<span class="status">{{ $statusData['label'] }}</span>
															</span>
															</a>
														<?php endforeach; ?>
													</div>
												<?php endif; ?>
											</div>
										</td>
									</tr>
									<tr>
										<th>Created On</th>
										<td><?php echo _dt($page->created) ?></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
					<div class="card listing-block">
						<div class="card-header">
							<div class="row align-items-center">
								<div class="col-md-8">
									<h3 class="mb-0">Ordered Product's</h3>
								</div>
								<div class="col-md-4">
									<div class="input-group input-group-alternative input-group-merge">
										<div class="input-group-prepend">
											<span class="input-group-text"><i class="fas fa-search"></i></span>
										</div>
										<input class="form-control listing-search" placeholder="Search" type="text" value="<?php echo (isset($_GET['search']) && $_GET['search'] ? $_GET['search'] : '') ?>">
									</div>
								</div>
							</div>
						</div>
						<div class="card-body p-0">
							@include('admin.orders.orderedProducts.index',['listing' => $listing])
						</div>
					</div>
					<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">Billing Details</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive small-max-card-table">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<tbody>
								<tr>
									<th>Subtotal</th>
									<td><?php echo $currency.' '.$page->subtotal ?></td>
								</tr>
								<tr>
									<th>Discount</th>
									<td><?php echo $currency.' '.$page->discount ?></td>
								</tr>
								<tr>
									<th>Tax & Charges</th>
									<td><?php echo $page->tax ?></td>
								</tr>
								<tr>
									<th>Total Amount</th>
									<td><?php echo $currency.' '.$page->total_amount ?></td>
								</tr>
								<tr>
									<th>Applied Coupon</th>
									<td>
										<?php if ($page->coupon): ?>
											<a href="{{ route('admin.coupons.view', ['id' => $page->coupon->id]) }}">
												{{ $page->coupon->title }}
											</a>
										<?php else: ?>
											Coupon not applied.
										<?php endif; ?>
									</td>

								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xl-5 order-xl-1">	
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">Assign Staff</h3>
							</div>
						</div>
					</div>
					<div class="card-body">
						<form method="post" id="" action="<?php echo route('admin.orders.selectStaff', ['id' => $page->id]); ?>" class="form-validation" enctype="multipart/form-data">
							<!--!! CSRF FIELD !!-->
							{{ @csrf_field() }}	
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
									<label class="form-control-label">Staff</label>
										<select class="form-control" name="staff_id" required>
											<option value="">Select</option>
											<?php 
												foreach($staff as $s): 
												$content =  $s->first_name . " " . $s->last_name . "<small class='badge badge-".($s->status ? "success" : "danger")."'>".($s->status ? "Active" : "Inactive")."</small>";
											?>
											<option 
												value="<?php echo $s->id ?>" 
												<?php echo old('staff_id', $page->staff_id) == $s->id  ? 'selected' : '' ?>
												data-content="<?php echo $content ?>"
											>
												<?php echo $s->name; ?>		
											</option>
											<?php endforeach; ?>
										</select>
										@error('staff_id')
											<small class="text-danger">{{ $message }}</small>
										@enderror
									</div>
								</div>
							</div>
							<button type="submit" class="btn btn-sm py-2 px-3 btn-primary float-right">
								<i class="fa fa-save"></i> Submit
							</button>
						</form>
					</div>
				</div>
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-9">
								<h3 class="mb-0">Status Change History</h3>
							</div>
						</div>
					</div>
					<div class="card-body remarks-block">
						@foreach($history as $change)
							<div class="row align-items-top p-2">
								<div class="col-auto text-center">
									<span class="avatar avatar-sm rounded-circle">
										<?php
											$admin = \App\Models\Admin\Admins::find($change->created_by);
										?>
										@if($admin)
											<?php $image = $admin->image ? $admin->getResizeImagesAttribute() : []; ?>
											<img alt="Image placeholder" src="<?php echo isset($image['medium']) ? url($image['medium']) : url('assets/img/noprofile.jpg'); ?>">
										@else
											<img alt="Image placeholder" src="{{ url('assets/img/noprofile.jpg') }}">
										@endif
									</span>
								</div>
								<div class="col ml--1">
									<div class="d-flex justify-content-between align-items-top">
										<div>
											<h4 class="mb-0 text-sm" style="font-size: 14px !important;padding-right: 10px;">{{ $admin ? ($admin->first_name . ($admin->last_name ? ' ' . $admin->last_name : '')) : null  }}</h4>
											@if ($change->staff_id)
												<p class="text-success m-0" style="font-size: 12px !important;">
													Assigned Staff: {{ $change->staff ? $change->staff->first_name : null}} {{ $change->staff ? $change->staff->last_name : null }}
												</p>
												@elseif($change->field)
													@php
														$fieldName = ucfirst(str_replace('_', ' ', $change->field));
														$new = $change->new_value;
														if ($change->field == 'booking_time') {
															$new = _time($new);
															$old = _time($change->old_value); 
														} elseif ($change->field == 'booking_date') {
															$new = _d($new);
															$old = _d($change->old_value); 
														}
													@endphp
													<p class="text-muted m-0" style="font-size: 12px !important;">Updated {{ $fieldName }} from {{ $old }} to {{ $new }}</p>
												@endif
										</div>
										<div class="text-right">
											@if ($change->status)
												<span class="mx-3 badge" style="{{ $status[$change->status]['styles'] }}">{{ $status[$change->status]['label'] }}</span>
											@endif										
										</div>
									</div>
									<p class="text-danger m-0" style="font-size: 12px !important;">At: {{ _dt($change->created) }}</p>
								</div>
							</div>
							<div class="dropdown-divider"></div>
						@endforeach
					</div>
				</div>
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-7">
								<h3 class="mb-0"><span id="total-comments"></span> Comments</h3>
							</div>
							<div class="col text-right">
								<button type="button" onclick="$('#post-comments').slideToggle();" class="btn btn-sm btn-primary add-fault-log"><i class="fa fa-plus"></i> Add Comment</button>
							</div>
						</div>
					</div>
					<div class="post-comments px-2 pt-3" id="post-comments" style="display:none">
						<input type="hidden" value="<?php echo $page && $page->id ? $page->id : '' ?>" />
						<div class="row post-block">
							<div class="col-md-12">
								<div class="form-group">
									<textarea class="form-control" placeholder="Enter your comment." maxlength="255" name="remarks"></textarea>
									<small class="text-right autofill d-none"><a href="javascript:;">Auto-fill Response</a></small>
								</div>
								<?php if($page && $page->id): ?>
								<div class="form-group text-right">
									<small class="text-danger d-none error"></small>
									<button type="button" id="save-comment" class="btn btn-sm btn-primary text-uppercase">comment</button>
								</div>
								<?php endif; ?>
							</div>
						</div>
					</div>
					<div class="app px-2">
						<div class="bg-white rounded-3 shadow-sm p-1">
							<div class="remarks-block">
								<div class="py-2" id="trip-comments" data-id="<?php echo $page && $page->id ? $page->id : '' ?>" data-module="order">
									<p class="text-center"><i class="fa fa-spin fa-spinner"></i></p>
								</div>
								<p class="text-center"><a href="javascript:;" class="btn btn-sm btn-primary load-more-remarks d-none">Load More</a></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<div class="modal fade" id="remarsk-update" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Update Comment</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      	<div class="modal-body">
      		<form class="post-comments">
      			<input type="hidden" name="id" />
	  			<div class="row post-block">
					<div class="col-md-12">
						<div class="form-group">
							<textarea class="form-control" placeholder="Enter your comment." maxlength="255" name="remarks"></textarea>
						</div>
						<div class="form-group text-right">
							<small class="text-danger d-none error"></small>
		                   	<button type="button" id="update-comment" class="btn btn-sm btn-primary text-uppercase">Update</button>
		                </div>
					</div>
				</div>
			</form>
	    </div>
    </div>
  </div>
</div>
@endsection
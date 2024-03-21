@extends('layouts.adminlayout')
@section('content')
<?php
use App\Models\Admin\Permissions;
?>
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Manage Rating</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
						<a href="<?php echo route('admin.ratings') ?>" class="btn btn-neutral"><i class="fa fa-arrow-left"></i> Back</a>
						<a href="#" class="btn btn-neutral" target="_blank"><i class="fa fa-eye"></i> View Page</a>
						<?php if(Permissions::hasPermission('ratings', 'update') || Permissions::hasPermission('ratings', 'delete')): ?>
							<div class="dropdown" data-toggle="tooltip" data-title="More Actions">
								<a class="btn btn-neutral" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="fas fa-ellipsis-v"></i>
								</a>
								<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
									<?php if(Permissions::hasPermission('ratings', 'update')): ?>
										<a class="dropdown-item" href="<?php echo route('admin.ratings.edit', ['id' => $page->id]) ?>">
											<i class="fas fa-pencil-alt text-info"></i>
											<span class="status">Edit</span>
										</a>
										<?php endif; ?>
									<?php if(Permissions::hasPermission('ratings', 'delete')): ?>
										<div class="dropdown-divider"></div>
										<a 
											class="dropdown-item _delete" 
											href="javascript:;"
											data-link="<?php echo route('admin.ratings.delete', ['id' => $page->id]) ?>"
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
	<div id="staff">
		<div class="container-fluid mt--6">
			<div class="row">
				<div class="col-xl-8 order-xl-1">
					<div class="card">
						<!--!! FLAST MESSAGES !!-->
						@include('admin.partials.flash_messages')
						<div class="card-header">
							<div class="row align-items-center">
								<div class="col-8">
									<h3 class="mb-0">Color Information</h3>
								</div>
							</div>
						</div>
						<div class="table-responsive">
							<!-- Projects table -->
							<table class="table align-items-center table-flush">
								<tbody>
									<tr>
										<th>Id</th>
										<td><?php echo $page->id ?></td>
									</tr>
									<tr>
										<th>Name</th>
										<td><?php echo $page->name ?></td>
									</tr>
									<tr>
										<th>Designation</th>
										<td><?php echo $page->designation ?></td>
									</tr>
									<tr>
										<th>Rating</th>
										<td><?php echo $page->rating ?></td>
									</tr>
									<tr>
										<th>Image(On/Off)</th>
										<td>
											<div class="custom-control">
												<label class="custom-toggle">
													<?php $switchUrl =  route('admin.actions.switchUpdate', ['relation' => 'ratings', 'field' => 'image_status', 'id' => $page->id]); ?>
													<input type="checkbox" name="image_status" onchange="switch_action('<?php echo $switchUrl ?>', this)" value="1" <?php echo ($page->image_status ? 'checked' : '') ?>>
													<span class="custom-toggle-slider rounded-circle" data-label-off="OFF" data-label-on="ON"></span>
												</label>
											</div>
										</td>
									</tr>
									<tr>
										<th>Status</th>
										<td>
											<div class="custom-control">
												<label class="custom-toggle">
													<?php $switchUrl =  route('admin.actions.switchUpdate', ['relation' => 'ratings', 'field' => 'status', 'id' => $page->id]); ?>
													<input type="checkbox" name="status" onchange="switch_action('<?php echo $switchUrl ?>', this)" value="1" <?php echo ($page->status ? 'checked' : '') ?>>
													<span class="custom-toggle-slider rounded-circle" data-label-off="OFF" data-label-on="ON"></span>
												</label>
											</div>
										</td>
									</tr>
									<tr>
										<th colspan="2">Message:<br /><?php echo nl2br($page->message) ?></th>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="col-xl-4 order-xl-1">
					<div class="card">
						<div class="card-header">
							<div class="row align-items-center">
								<div class="col">
									<h3 class="mb-0">Other Information</h3>
								</div>
							</div>
						</div>
						<div class="table-responsive">
							<!-- Projects table -->
							<table class="table align-items-center table-flush">
								<tbody>
									<tr>
										<th scope="row">
											Created By
										</th>
										<td>
											<?php echo isset($page->owner) ? $page->owner->first_name . ' ' . $page->owner->last_name : "-" ?>
										</td>
									</tr>
									<tr>
										<th scope="row">
											Created On
										</th>
										<td>
											<?php echo _dt($page->created) ?>
										</td>
									</tr>
									<tr>
										<th scope="row">
											Last Modified
										</th>
										<td>
											<?php echo _dt($page->modified) ?>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
@endsection
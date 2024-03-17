@extends('layouts.adminlayout')
@section('content')
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Manage Sliders</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
					<?php if(Permissions::hasPermission('sliders', 'create')): ?>
						<a href="<?php echo route('admin.sliders.add') ?>" class="btn btn-neutral">
						<i class="fas fa-plus"></i> New</a>
					<?php endif; ?>	
						@include('admin.sliders.filters')
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Page content -->
	<div class="container-fluid mt--6">
		<div class="row">
			<div class="col">
<!--!!!!! DO NOT REMOVE listing-block CLASS. INCLUDE THIS IN PARENT DIV OF TABLE ON LISTING PAGES !!!!!-->
				<div class="card listing-block">
					<!--!! FLAST MESSAGES !!-->
					@include('admin.partials.flash_messages')
					<!-- Card header -->
					<div class="card-header border-0">
						<div class="heading">
							<h3 class="mb-0">Here Is Your Slider Listing!</h3>
						</div>
						<div class="actions">
							<div class="input-group input-group-alternative input-group-merge">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fas fa-search"></i></span>
								</div>
								<input class="form-control listing-search" placeholder="Search" type="text" value="<?php echo (isset($_GET['search']) && $_GET['search'] ? $_GET['search'] : '') ?>">
							</div>
							<?php if(Permissions::hasPermission('sliders', 'update') || Permissions::hasPermission('sliders', 'delete')): ?>
								<div class="dropdown" data-toggle="tooltip" data-title="Bulk Actions">
									<a class="btn btn-sm btn-icon-only text-warning" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<i class="fas fa-ellipsis-v"></i>
									</a>
									<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
										<?php if(Permissions::hasPermission('sliders', 'delete')): ?>
											<a 
												href="javascript:void(0);" 
												class="waves-effect waves-block dropdown-item text-danger" 
												onclick="bulk_actions('<?php echo route('admin.sliders.bulkActions', ['action' => 'delete']) ?>', 'delete');">
													<i class="fas fa-times text-danger"></i>
													<span class="status text-danger">Delete</span>
											</a>
										<?php endif; ?>
									</div>
								</div>
							<?php endif; ?>
						</div>
					</div>
					<div class="table-responsive">
<!--!!!!! DO NOT REMOVE listing-table, mark_all  CLASSES. INCLUDE THIS IN ALL TABLES LISTING PAGES !!!!!-->
						<table class="table align-items-center table-flush listing-table">
							<thead class="thead-light">
								<tr>
									<th width="5%" class="checkbox-th">
										<div class="custom-control custom-checkbox">
											<input type="checkbox" class="custom-control-input mark_all" id="mark_all">
											<label class="custom-control-label" for="mark_all"></label>
										</div>
									</th>
									<th class="sort" width="5%">
										<!--- MAKE SURE TO USE PROPOER FIELD IN data-field AND PROPOER DIRECTION IN data-sort -->
										Id
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'sliders.id' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="sliders.id" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'sliders.id' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="sliders.id" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="sliders.id" data-sort="asc"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="17%">
										Label
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'sliders.label' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="sliders.label" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'sliders.label' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="sliders.label" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="sliders.label"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="10%">
										Button Status
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'sliders.button_status' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="sliders.button_status" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'sliders.button_status' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="sliders.button_status" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="sliders.button_status"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="10%">
										Heading
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'sliders.heading' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="sliders.heading" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'sliders.heading' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="sliders.heading" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="sliders.heading"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="31%">
										Sub Heading
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'sliders.sub_heading' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="sliders.sub_heading" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'sliders.sub_heading' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="sliders.sub_heading" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="sliders.sub_heading"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="17%">
										Button Title
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'sliders.button_title' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="sliders.button_title" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'sliders.button_title' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="sliders.button_title" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="sliders.button_title"></i>
										<?php endif; ?>
									</th>
									<th width="5%">
										Actions
									</th>
								</tr>
							</thead>
							<tbody class="list">
								<?php if(!empty($listing->items())): ?>
									@include('admin.sliders.listingLoop')
								<?php else: ?>
									<td align="left" colspan="7">
		                            	No records found!
		                            </td>
								<?php endif; ?>
							</tbody>
							<tfoot>
		                        <tr>
		                            <th align="left" colspan="20">
		                            	@include('admin.partials.pagination', ["pagination" => $listing])
		                            </th>
		                        </tr>
		                    </tfoot>
						</table>
					</div>
					<!-- Card footer -->
				</div>
			</div>
		</div>
	</div>
@endsection
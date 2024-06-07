@extends('layouts.adminlayout')
@section('content')
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Manage Colours</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
					<?php if(Permissions::hasPermission('colours', 'create')): ?>
						<a href="<?php echo route('admin.colours.add') ?>" class="btn btn-neutral">
						<i class="fas fa-plus"></i> New</a>
					<?php endif; ?>	
						@include('admin.colours.filters')
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
							<h3 class="mb-0">Here Is Your Colour Listing!</h3>
						</div>
						<div class="actions">
							<div class="input-group input-group-alternative input-group-merge">
								<div class="input-group-prepend">
									<span class="input-group-text"><i class="fas fa-search"></i></span>
								</div>
								<input class="form-control listing-search" placeholder="Search" type="text" value="<?php echo (isset($_GET['search']) && $_GET['search'] ? $_GET['search'] : '') ?>">
							</div>
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
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'colours.id' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="colours.id" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'colours.id' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="colours.id" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="colours.id" data-sort="asc"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="10%">
										Colour Title
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'colours.title' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="colours.title" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'colours.title' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="colours.title" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="colours.title"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="15%">
										Colour Code
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'colours.code' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="colours.code" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'colours.code' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="colours.code" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="colours.code"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="15%">
										HEX Code
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'colours.color_code' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="colours.color_code" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'colours.color_code' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="colours.color_code" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="colours.color_code"></i>
										<?php endif; ?>
									</th>
									<th class="sort" width="10%">
										Created ON
										<?php if(isset($_GET['sort']) && $_GET['sort'] == 'colours.created' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
										<i class="fas fa-sort-down active" data-field="colours.created" data-sort="asc"></i>
										<?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'colours.created' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
										<i class="fas fa-sort-up active" data-field="colours.created" data-sort="desc"></i>
										<?php else: ?>
										<i class="fas fa-sort" data-field="colours.created"></i>
										<?php endif; ?>
									</th>
									<th width="5%">
										Actions
									</th>
								</tr>
							</thead>
							<tbody class="list">
								<?php if(!empty($listing->items())): ?>
									@include('admin.colours.listingLoop')
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
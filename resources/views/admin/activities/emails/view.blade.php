@extends('layouts.adminlayout')
@section('content')
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Email Logs</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
						<a href="<?php echo route('admin.activities.emails') ?>" class="btn btn-neutral"><i class="fa fa-arrow-left"></i> Back</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Page content -->
	<div class="container-fluid mt--6">
		<div class="row">
			<div class="col-xl-8 order-xl-1">
				<div class="card">
					<!--!! FLAST MESSAGES !!-->
					@include('admin.partials.flash_messages')
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col-8">
								<h3 class="mb-0">Email Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush view-table">
							<tbody>
								<tr>
									<th>Id</th>
									<td><?php echo $log->id ?></td>
								</tr>
								<tr>
									<th>From</th>
									<td><?php echo $log->from ?></td>
								</tr>
								<tr>
									<th>To</th>
									<td><?php echo $log->to ?></td>
								</tr>
								<tr>
									<th>Subject</th>
									<td><?php echo $log->subject ?></td>
								</tr>
								<tr>
									<td colspan="2">
										<h3>Message</h3>
										<?php echo $log->description ?>
									</td>
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
								<h3 class="mb-0">Access Information</h3>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush view-table">
							<tbody>
								<tr>
									<th scope="row">
										Created On
									</th>
									<td>
										<?php echo _dt($log->created) ?>
									</td>
								</tr>
								<tr>
									<th scope="row" class="text-center">
										<?php echo $log->sent ? '<span class="badge badge-success">Sent</span>' : '<span class="badge badge-danger">Not Sent</span>' ?>
									</th>
									<td class="text-center">
										<?php echo $log->open ? '<span class="badge badge-success">Open</span>' : '<span class="badge badge-danger">Not Open</span>' ?>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
@endsection
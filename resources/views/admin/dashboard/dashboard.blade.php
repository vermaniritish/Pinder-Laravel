@extends('layouts.adminlayout')
@section('content')
	<div class="header bg-primary pb-6">
		<div class="container-fluid">
			<div class="header-body">
				<div class="row align-items-center py-4">
					<div class="col-lg-6 col-7">
						<h6 class="h2 text-white d-inline-block mb-0">Dashboard</h6>
					</div>
					<div class="col-lg-6 col-5 text-right">
					</div>
				</div>
				<!-- Card stats -->
				<div class="row">
					<div class="col-xl-4 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">Total Customer</h5>
										<span class="h2 font-weight-bold mb-0">350,897</span>
									</div>
									<div class="col-auto">
										<div class="icon icon-shape bg-gradient-cyan text-white rounded-circle shadow">
											<i class="fa fa-users"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">Total Sellers</h5>
										<span class="h2 font-weight-bold mb-0">350,897</span>
									</div>
									<div class="col-auto">
										<div class="icon icon-shape bg-gradient-teal text-white rounded-circle shadow">
											<i class="fa fa-users"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-xl-4 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">Total Products</h5>
										<span class="h2 font-weight-bold mb-0">2,356</span>
									</div>
									<div class="col-auto">
										<div class="icon icon-shape bg-gradient-pink text-white rounded-circle shadow">
											<i class="ni ni-chart-pie-35"></i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Page content -->
	<div class="container-fluid mt--6">	
		<div class="row">
			<div class="col-xl-8">
				<div class="card">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0 text-white">Page visits</h3>
							</div>
							<div class="col text-right">
								<a href="#!" class="btn btn-sm py-2 px-3 btn-primary">See all</a>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<thead class="thead-light">
								<tr>
									<th scope="col">Page name</th>
									<th scope="col">Visitors</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">
										/argon/
									</th>
									<td>
										4,569
									</td>
								</tr>
								<tr>
									<th scope="row">
										/argon/index.html
									</th>
									<td>
										3,985
									</td>
								</tr>
								<tr>
									<th scope="row">
										/argon/charts.html
									</th>
									<td>
										3,513
									</td>
								</tr>
								<tr>
									<th scope="row">
										/argon/tables.html
									</th>
									<td>
										2,050
									</td>
								</tr>
								<tr>
									<th scope="row">
										/argon/profile.html
									</th>
									<td>
										1,795
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-xl-4">
				<div class="card">
					<div class="card-header border-0">
						<div class="row align-items-center">
							<div class="col">
								<h3 class="mb-0">Social traffic</h3>
							</div>
							<div class="col text-right">
								<a href="#!" class="btn btn-sm py-2 px-3 btn-primary">See all</a>
							</div>
						</div>
					</div>
					<div class="table-responsive">
						<!-- Projects table -->
						<table class="table align-items-center table-flush">
							<thead class="thead-light">
								<tr>
									<th scope="col">Referral</th>
									<th scope="col">Visitors</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">
										Facebook
									</th>
									<td>
										1,480
									</td>
								</tr>
								<tr>
									<th scope="row">
										Facebook
									</th>
									<td>
										5,480
									</td>
								</tr>
								<tr>
									<th scope="row">
										Google
									</th>
									<td>
										4,807
									</td>
								</tr>
								<tr>
									<th scope="row">
										Instagram
									</th>
									<td>
										3,678
									</td>
								</tr>
								<tr>
									<th scope="row">
										twitter
									</th>
									<td>
										2,645
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
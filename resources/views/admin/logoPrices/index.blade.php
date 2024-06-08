@extends('layouts.adminlayout')
@section('content')
<div class="header bg-primary pb-6">
	<div class="container-fluid">
		<div class="header-body">
			<div class="row align-items-center pt-4 pb-2">
				<div class="col-lg-6 col-7">
					<h6 class="h2 text-white d-inline-block mb-0">Manage Logo Prices</h6>
				</div>
				<div class="col-lg-6 col-5 text-right">
				</div>
			</div>
			<div class="row align-items-center pb-4 pl-3">
			</div>
		</div>
	</div>
</div>
<!-- Page content -->
<div class="container-fluid mt--6">
	<div class="row">
		<div id="logoPrices" class="col-xl-12 order-xl-1">
			<!--!! FLASH MESSAGES !!-->
			@include('admin.partials.flash_messages')
		    <div class="card">
				<div class="card-header border-0">
					<div class="heading">
						<h3 class="mb-0">Embroidery</h3>
					</div>
					<div class="actions">
						<button v-on:click="addRow('embroidered-logo')" class="btn-sm btn-primary"><i class="fas fa-plus"></i> Add</button>
					</div>
				</div>
				<div class="card-body p-0">
					<div class="table-responsive">
						<table class="table align-items-center table-flush listing-table">
							<thead class="thead-light">
								<tr>
									<th>From Quantity</th>
									<th>To Quantity</th>
									<th v-for="position in logoPositions" :key="position">@{{ position }}</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(row, index) in embroideryRows" :key="index">
									<td><input type="number" v-model="row.from_quantity" class="form-control"></td>
									<td><input type="number" v-model="row.to_quantity" class="form-control"></td>
									<td v-for="position in logoPositions" :key="position">
										<input type="number" v-model="row.prices[position]" class="form-control">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		    <div class="card">
				<div class="card-header border-0">
					<div class="heading">
						<h3 class="mb-0">Printing</h3>
					</div>
					<div class="actions">
						<button v-on:click="addRow('printed-logo')" class="btn-sm btn-primary"><i class="fas fa-plus"></i> Add</button>
					</div>
				</div>
				<div class="card-body p-0">
					<div class="table-responsive">
						<table class="table align-items-center table-flush listing-table">
							<thead class="thead-light">
								<tr>
									<th>From Quantity</th>
									<th>To Quantity</th>
									<th v-for="position in logoPositions" :key="position">@{{ position }}</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(row, index) in printingRows" :key="index">
									<td><input type="number" v-model="row.from_quantity" class="form-control"></td>
									<td><input type="number" v-model="row.to_quantity" class="form-control"></td>
									<td v-for="position in logoPositions" :key="position">
										<input type="number" v-model="row.prices[position]" class="form-control">
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
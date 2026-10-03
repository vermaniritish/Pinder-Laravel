@extends('layouts.adminlayout')
@section('content')
    <div class="header bg-primary pb-6">
        <div class="container-fluid">
            <div class="header-body">
                <div class="row align-items-center py-4">
                    <div class="col-12">
                        <h6 class="h2 text-white d-inline-block mb-0">Uniform Sales Breakup - Cumulative</h6>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid mt--6">
        <div class="card mb-3">
            <div class="card-body">
                <form method="get" action="{{ route('admin.orders.uniformSalesReport') }}">
                    <div class="form-row align-items-end">
                        <div class="col-lg-3 col-md-6">
                            <label for="school_id">School</label>
                            <select class="form-control" name="school_id" id="school_id">
                                <option value="">All schools</option>
                                @foreach ($schoolOptions as $school)
                                    <option value="{{ $school->id }}" {{ (string) ($filters['school_id'] ?? '') === (string) $school->id ? 'selected' : '' }}>{{ $school->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <label for="category_id">Category</label>
                            <select class="form-control" name="category_id" id="category_id">
                                <option value="">All categories</option>
                                @foreach ($categoryOptions as $category)
                                    <option value="{{ $category->id }}" {{ (string) ($filters['category_id'] ?? '') === (string) $category->id ? 'selected' : '' }}>{{ $category->title }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-lg-2 col-md-6">
                            <label for="status">Order status</label>
                            <select class="form-control" name="status" id="status">
                                <option value="">Default statuses</option>
                                @foreach (\App\Models\Admin\Orders::getStatuses() as $statusKey => $status)
                                    <option value="{{ $statusKey }}" {{ ($filters['status'] ?? '') === $statusKey ? 'selected' : '' }}>{{ $status['label'] }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="col-lg-1 col-md-6">
                            <label for="start_date">Start date</label>
                            <input class="form-control" type="date" name="start_date" id="start_date" value="{{ $filters['start_date'] ?? '' }}">
                        </div>
                        <div class="col-lg-1 col-md-6">
                            <label for="end_date">End date</label>
                            <input class="form-control" type="date" name="end_date" id="end_date" value="{{ $filters['end_date'] ?? '' }}">
                        </div>
                        <div class="col-lg-2 d-flex mt-3 mt-lg-0">
                            <button class="btn btn-primary mr-2" type="submit">Display</button>
                            <button class="btn btn-secondary" type="button" onclick="window.print()" title="Print report"><i class="fas fa-print"></i></button>
                        </div>
                    </div>
                    @if ($errors->any())
                        <div class="text-danger mt-2">{{ $errors->first() }}</div>
                    @endif
                </form>
                <div class="mt-3 text-right">
                    <a class="btn btn-sm btn-outline-primary" href="{{ route('admin.orders.uniformSalesReportPdf', request()->query()) }}">
                        <i class="fas fa-file-pdf"></i> Download PDF
                    </a>
                </div>
            </div>
        </div>

        <div class="card report-print-area">
            <div class="card-body p-3">
                @include('admin.orders.uniformSalesReportTable')
            </div>
        </div>
    </div>
    <style>
        @media print {
            .sidenav, .navbar, .header, form, .btn, .card { display: none !important; }
            .report-print-area, .report-print-area .card-body { display: block !important; padding: 0 !important; border: 0 !important; }
            .container-fluid { width: 100% !important; max-width: none !important; margin: 0 !important; padding: 0 !important; }
            .uniform-sales-report { font-size: 10px; }
        }
    </style>
@endsection
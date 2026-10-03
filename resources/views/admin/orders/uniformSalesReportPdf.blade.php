<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        body { font-family: sans-serif; font-size: 9pt; }
        h2 { font-size: 15pt; margin: 0 0 12px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border-bottom: 1px solid #ddd; padding: 5px 7px; text-align: left; }
        th { background: #eee; }
        .school-heading td { background: #777; color: #fff; font-weight: bold; }
        .quantity { width: 15%; text-align: center; }
        .size-list div { padding: 2px 0; }
        .grand-total td { background: #e5e5e5; font-weight: bold; }
    </style>
</head>
<body>
    <h2>Uniform Sales Breakup - Cumulative</h2>
    @include('admin.orders.uniformSalesReportTable')
</body>
</html>
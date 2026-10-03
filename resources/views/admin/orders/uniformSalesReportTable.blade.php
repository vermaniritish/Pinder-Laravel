<table class="uniform-sales-report" style="width: 100%; border-collapse: collapse;">
    <thead>
        <tr>
            <th style="text-align: left; padding: 6px;">Uniform / Colour</th>
            <th style="text-align: left; padding: 6px;">Size / Length</th>
            <th style="text-align: center; padding: 6px;">Cumulative Qty</th>
        </tr>
    </thead>
    <tbody>
        @forelse ($schools as $schoolName => $products)
            <tr class="school-heading">
                <td colspan="3" style="background: #777; color: #fff; font-weight: bold; padding: 5px 6px;">{{ $schoolName }}</td>
            </tr>
            @foreach ($products as $product)
                <tr>
                    <td style="padding: 6px; border-bottom: 1px solid #ddd;">
                        <strong>{{ $product['title'] }}</strong><br>
                        <small>Colour: {{ $product['color'] }}</small>
                    </td>
                    <td class="size-list" style="padding: 6px; border-bottom: 1px solid #ddd;">
                        @foreach ($product['sizes'] as $size)
                            <div>{{ $size['title'] }} ({{ $size['quantity'] }})</div>
                        @endforeach
                    </td>
                    <td style="text-align: center; padding: 6px; border-bottom: 1px solid #ddd;">{{ $product['total'] }}</td>
                </tr>
            @endforeach
        @empty
            <tr><td colspan="3" class="text-center" style="padding: 16px;">No sales found for the selected filters.</td></tr>
        @endforelse
        <tr class="grand-total">
            <td colspan="2" style="padding: 7px; font-weight: bold;">GRAND TOTAL</td>
            <td style="text-align: center; padding: 7px; font-weight: bold;">{{ $grandTotal }}</td>
        </tr>
    </tbody>
</table>
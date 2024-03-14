<?php

use App\Models\Admin\OrderProductRelation;

 foreach($listing->items() as $k => $row): ?>
<tr>
	<td>
		<a href="<?php echo route('admin.orders.view', ['id' => $row->id]) ?>"><?php echo $row->id; ?></a>
	</td>
	<td>
		@foreach ($row->products as $index => $product)
			<?php $product = OrderProductRelation::whereOrderId($row->id)->whereProductId($product->id)->first();?>
			{{ $product->product_title }}
			<i title="Amount: {{$currency}} {{ $product->amount }}, Quantity: {{ $product->quantity }}">
				| Amount: {{$currency}} {{ $product->amount }} | Quantity: {{ $product->quantity }}
			</i>
			@if (!$loop->last)
				<br>
			@endif
		@endforeach
	</td>
	<td>
		<?php $statusData = $status[$row->status] ?? null; ?>
		<?php if ($statusData): ?>
			<button class="btn btn-sm" style="<?php echo $statusData['styles']; ?>"
					type="button" id="statusDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
					data-toggle="tooltip" title="{{ $row->statusBy ? ($row->statusBy->first_name . ($row->statusBy->last_name ? ' ' . $row->statusBy->last_name : '')) : null }}">
				{{ $statusData['label'] }}
			</button>
		<?php endif; ?>
	</td>
    <td>
	{{ _dt($row->created) }}
	</td>
	<td style="font-size: 16px; font-weight: bold;">
		{{$currency}} {{$row->total_amount }}
	</td>
</tr>
<?php endforeach; ?>
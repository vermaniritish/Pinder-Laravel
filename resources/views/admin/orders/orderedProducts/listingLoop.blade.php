<?php foreach($listing->items() as $k => $row): ?>
<tr>
	<td>
		<a href="{{ route('admin.products.view', ['id' => $row->product_id]) }}">
			{{ $row->product_id }}
		</a>
	</td>
	<td>
		<?php echo $row->product_title ?>
	</td>
	<td>
		<?php echo $row->quantity ?>
	</td>
    <td>
		<?php echo $row->amount ? _currency($row->amount) : _currency(0) ?>
	</td>
</tr>
<?php endforeach; ?>
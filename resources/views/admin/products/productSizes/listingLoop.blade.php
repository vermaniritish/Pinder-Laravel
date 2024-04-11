<?php
use App\Models\Admin\Permissions;
use App\Models\Admin\Settings;
	$currency = Settings::get('currency_symbol'); 
?>
<?php foreach($listing->items() as $k => $row): ?>
<tr>
	<td>
		<span style="background-color: {{ $row->colors->color_code }}" class="badge badge-secondary">{{ $row->colors->title }}</span>
	</td>
	<td>
		<?php echo $row->size_title ?>
	</td>
	<td>
		<?php echo $row->from_cm ?>
	</td>
    <td>
		<?php echo $row->to_cm ?>
	</td>
    <td>
		<?php echo $currency . ' ' . $row->price ?>
	</td>
</tr>
<?php endforeach; ?>
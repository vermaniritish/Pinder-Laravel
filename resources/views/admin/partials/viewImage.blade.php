<?php 
if(is_array($files) && !empty($files) && isset($files[0])): ?>
	<div class="owl-carousel owl-theme">
		<?php 
		foreach ($files as $key => $value): 
			$value = isset($value['medium']) && $value['medium'] ? $value['medium'] : (isset($value['original']) && $value['original'] ? $value['original'] : "");
			if($value):
		?>
			<div class="item <?php echo $key < 1 ? ' active' : '' ?>">
				<img src="<?php echo url($value) ?>" alt="">
			</div>
		<?php 
			endif;
		endforeach; ?>
	</div>
<?php elseif(!empty($files)): ?>
	<?php $value = isset($files['medium']) && $files['medium'] ? $files['medium'] : (isset($value['original']) && $value['original'] ? $value['original'] : ""); ?>
	<?php if($value): ?>
	<img src="<?php echo url($value) ?>">
	<?php endif; ?>
<?php endif; ?>

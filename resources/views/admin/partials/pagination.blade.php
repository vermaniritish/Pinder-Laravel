<?php
use App\Models\Admin\Settings;
$paginationMethod = Settings::get('pagination_method');
?>
<?php if($paginationMethod && $paginationMethod == 'scroll'): ?>
<div class="ajaxPaginationEnabled loader text-center hidden" data-url="<?php echo $pagination->path() ?>" data-page="1" data-counter="<?php echo $pagination->perPage() ?>" data-total="<?php echo $pagination->total() ?>">
    <div class="preloader pl-size-xs">
        <div class="spinner-layer pl-indigo">
            <div class="circle-clipper left">
                <div class="circle"></div>
            </div>
            <div class="circle-clipper right">
                <div class="circle"></div>
            </div>
        </div>
    </div>
</div>
<?php else: ?>
<div class="card-footer py-4">
	<?php echo $pagination->appends($_GET)->links() ?>
</div>
<?php endif; ?>
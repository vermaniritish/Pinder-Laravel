<div class="dropdown filter-dropdown">
	<a class="btn btn-neutral dropdown-btn" href="#" <?php echo (isset($_GET) && !empty($_GET) ? 'data-title="Filters are active" data-toggle="tooltip"' : '') ?>>
		<?php if(isset($_GET) && !empty($_GET)): ?>
		<span class="filter-dot text-info"><i class="fas fa-circle"></i></span>
		<?php endif; ?>
		<i class="fas fa-filter"></i> Filters
	</a>
	<div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
        <form action="<?php echo route('admin.staff.view',['id' => $page->id]) ?>" method="GET" id="filters-form">
            <a href="javascript:;" class="float-right px-2 closeit"><i class="fa fa-times-circle"></i></a>
            <div class="dropdown-item">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-control-label" for="fromDate">From Date:</label>
                            <input type="date" class="form-control" name="order_created[0]" value="{{ isset($_GET['order_created'][0]) ? $_GET['order_created'][0] : '' }}" placeholder="DD-MM-YYYY" >
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-control-label" for="toDate">To Date:</label>
                            <input type="date" class="form-control" name="order_created[1]" id="toDate" value="{{ isset($_GET['order_created'][1]) ? $_GET['order_created'][1] : '' }}" placeholder="DD-MM-YYYY" >
                        </div>
                    </div>
                </div>
            </div>
            <div class="dropdown-divider"></div>
			<a href="<?php echo route('admin.staff.view',['id' => $id]) ?>" class="btn btn-sm py-2 px-3 float-left">
				Reset All
			</a>
			<button href="#" class="btn btn-sm py-2 px-3 btn-primary float-right">
				Submit
			</button>
          
        </form>
    </div>
</div>
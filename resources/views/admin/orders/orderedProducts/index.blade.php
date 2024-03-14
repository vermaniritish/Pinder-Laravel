<div class="table-responsive">
    <!--!!!!! DO NOT REMOVE listing-table, mark_all  CLASSES. INCLUDE THIS IN ALL TABLES LISTING PAGES !!!!!-->
    <table class="table align-items-center table-flush listing-table">
        <thead class="thead-light">
            <tr>
                <th class="sort" width="10%">
                    <!--- MAKE SURE TO USE PROPOER FIELD IN data-field AND PROPOER DIRECTION IN data-sort -->
                    Id
                    <?php if(isset($_GET['sort']) && $_GET['sort'] == 'order_products.id' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
                    <i class="fas fa-sort-down active" data-field="order_products.id" data-sort="asc"></i>
                    <?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'order_products.id' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
                    <i class="fas fa-sort-up active" data-field="order_products.id" data-sort="desc"></i>
                    <?php else: ?>
                    <i class="fas fa-sort" data-field="order_products.id" data-sort="asc"></i>
                    <?php endif; ?>
                </th>
                <th class="sort" width="22.5%">
                    Product Title
                    <?php if(isset($_GET['sort']) && $_GET['sort'] == 'order_products.product_title' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
                    <i class="fas fa-sort-down active" data-field="order_products.product_title" data-sort="asc"></i>
                    <?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'order_products.product_title' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
                    <i class="fas fa-sort-up active" data-field="order_products.product_title" data-sort="desc"></i>
                    <?php else: ?>
                    <i class="fas fa-sort" data-field="order_products.product_title"></i>
                    <?php endif; ?>
                </th>
                <th class="sort" width="22.5%">
                    Quantity
                    <?php if(isset($_GET['sort']) && $_GET['sort'] == 'order_products.quantity' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
                    <i class="fas fa-sort-down active" data-field="order_products.quantity" data-sort="asc"></i>
                    <?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'order_products.quantity' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
                    <i class="fas fa-sort-up active" data-field="order_products.quantity" data-sort="desc"></i>
                    <?php else: ?>
                    <i class="fas fa-sort" data-field="order_products.quantity"></i>
                    <?php endif; ?>
                </th>				
                <th class="sort" width="22.5%" >
                    Price
                    <?php if(isset($_GET['sort']) && $_GET['sort'] == 'order_products.amount' && isset($_GET['direction']) && $_GET['direction'] == 'asc'): ?>
                    <i class="fas fa-sort-down active" data-field="order_products.amount" data-sort="asc"></i>
                    <?php elseif(isset($_GET['sort']) && $_GET['sort'] == 'order_products.amount' && isset($_GET['direction']) && $_GET['direction'] == 'desc'): ?>
                    <i class="fas fa-sort-up active" data-field="order_products.amount" data-sort="desc"></i>
                    <?php else: ?>
                    <i class="fas fa-sort" data-field="order_products.amount"></i>
                    <?php endif; ?>
                </th>
            </tr>
        </thead>
        <tbody class="list">
            <?php if(!empty($listing->items())): ?>
                @include('admin.orders.orderedProducts.listingLoop')
            <?php else: ?>
                <td align="left" colspan="7">
                    No records found!
                </td>
            <?php endif; ?>
        </tbody>
        <tfoot>
            <tr>
                <th align="left" colspan="20">
                    @include('admin.partials.pagination', ["pagination" => $listing])
                </th>
            </tr>
        </tfoot>
    </table>
</div>
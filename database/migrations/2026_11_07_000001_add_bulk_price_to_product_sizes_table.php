<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddBulkPriceToProductSizesTable extends Migration
{
    public function up()
    {
        Schema::table('product_sizes', function (Blueprint $table) {
            $table->decimal('bulk_price', 10, 2)->nullable()->after('sale_price');
        });
    }

    public function down()
    {
        Schema::table('product_sizes', function (Blueprint $table) {
            $table->dropColumn('bulk_price');
        });
    }
}
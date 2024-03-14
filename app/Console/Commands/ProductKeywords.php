<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Admin\Products;

class ProductKeywords extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'products:keywords';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Migrate products keywords';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $products = Products::select([
            'products.id',
            'products.title'
        ])
        ->with(['categories'])
        ->get();
        die('done');
    }
}

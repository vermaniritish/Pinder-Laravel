<?php

namespace App\Models\API;

use App\Models\Admin\OrderProductRelation;
use App\Models\Admin\Orders as AdminOrders;
use App\Models\AppModel;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Orders extends AdminOrders
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'customer_id',
        'booking_date',
        'booking_time',
        'address_id',
        // 'state',
        // 'city',
        // 'area',
        // 'payment_type' , 
        'coupon_code_id',
        'tax',
        'total_amount',
        'discount',
        'subtotal',
        'status',
        'status_by',
        'status_at'
    ];
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'orders';

    /**
     * The attributes that are not assignable.
     *
     * @var bool
     */
    protected $guarded = [];

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = false;

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'id';

    /**
     * Get the indexable data array for the model.
     *
     * @return array
     */
    public function toSearchableArray()
    {
        return [
        'customer_id' ,
        'booking_date' ,
        'booking_time' ,
        'address_id',
        // 'payment_type' , 
        'coupon_code_id',
        'tax',
        'total_amount',
        'discount',
        'subtotal'
        ];
    }
}

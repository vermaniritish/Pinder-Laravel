<?php

namespace App\Models\API;

use App\Models\Admin\Addresses as AdminAddresses;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Spatie\Activitylog\LogOptions;

class Addresses extends AdminAddresses
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'title',
        'address',
        'city',
        'state',
        'area',
        'latitude',
        'longitude',
        'user_id'
    ];
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'addresses';

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
            'id',
            'title',
            'address',
            'city',
            'state',
            'area',
            'latitude',
            'longitude'
        ];
    }
    
    /**
	 * Define attributes that need to be logged.
	 */
	public function getActivitylogOptions(): LogOptions {
		return LogOptions::defaults()
			->logAll()
			->dontLogIfAttributesChangedOnly(['updated_at'])
			->useLogName('users');
	}
}

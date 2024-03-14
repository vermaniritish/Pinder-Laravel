<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use App\Libraries\General;
use Spatie\Activitylog\LogOptions;

class OrderStatusHistory extends AppModel
{
    protected $table = 'order_status_history';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    /**
    * Pages -> Admins belongsTO relation
    * 
    * @return Admins
    */
    public function owner()
    {
        return $this->belongsTo(Admins::class, 'created_by', 'id');
    }

    /**
    * OrderStatusHistory -> Staff hasOne relation
    * 
    * @return Staff
    */
    public function staff()
    {
        return $this->hasOne(Staff::class, 'id','staff_id');
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getListing(Request $request, $where = [])
    {
        $orderBy = $request->get('sort') ? $request->get('sort') : 'orders.id';
        $direction = $request->get('direction') ? $request->get('direction') : 'desc';
        $page = $request->get('page') ? $request->get('page') : 1;
        $limit = self::$paginationLimit;
        $offset = ($page - 1) * $limit;
        
        $listing = OrderStatusHistory::select([
                'orders.*',
                'owner.first_name as owner_first_name',
                'owner.last_name as owner_last_name'
            ])
            ->leftJoin('admins as owner', 'owner.id', '=', 'orders.created_by')
            ->orderBy($orderBy, $direction);

        if(!empty($where))
        {
            foreach($where as $query => $values)
            {
                if(is_array($values))
                    $listing->whereRaw($query, $values);
                elseif(!is_numeric($query))
                    $listing->where($query, $values);
                else
                    $listing->whereRaw($values);
            }
        }

        // Put offset and limit in case of pagination
        if($page !== null && $page !== "" && $limit !== null && $limit !== "")
        {
            $listing->offset($offset);
            $listing->limit($limit);
        }

        $listing = $listing->paginate($limit);

        return $listing;
    }

    /**
    * To get all records
    * @param $where
    * @param $orderBy
    * @param $limit
    */
    public static function getAll($select = [], $where = [], $orderBy = 'orders.id desc', $limit = null)
    {
        $listing = OrderStatusHistory::orderByRaw($orderBy);

        if(!empty($select))
        {
            $listing->select($select);
        }
        else
        {
            $listing->select([
                'orders.*'
            ]); 
        }

        if(!empty($where))
        {
            foreach($where as $query => $values)
            {
                if(is_array($values))
                    $listing->whereRaw($query, $values);
                elseif(!is_numeric($query))
                    $listing->where($query, $values);
                else
                    $listing->whereRaw($values);
            }
        }
        
        if($limit !== null && $limit !== "")
        {
            $listing->limit($limit);
        }

        $listing = $listing->get();

        return $listing;
    }

    /**
    * To get single record by id
    * @param $id
    */
    public static function get($id)
    {
        $record = OrderStatusHistory::where('id', $id)
            ->with([
                'owner' => function($query) {
                    $query->select([
                            'id',
                            'first_name',
                            'last_name'
                        ]);
                }
            ])
            ->first();

        return $record;
    }

    /**
    * To get single row by conditions
    * @param $where
    * @param $orderBy
    */
    public static function getRow($where = [], $orderBy = 'orders.id desc')
    {
        $record = OrderStatusHistory::orderByRaw($orderBy);

        foreach($where as $query => $values)
        {
            if(is_array($values))
                $record->whereRaw($query, $values);
            elseif(!is_numeric($query))
                $record->where($query, $values);
            else
                $record->whereRaw($values);
        }
        
        $record = $record->limit(1)->first();

        return $record;
    }

    /**
    * To insert
    * @param $where
    * @param $orderBy
    */
    public static function create($data)
    {
        $page = new OrderStatusHistory();

        foreach($data as $k => $v)
        {
            $page->{$k} = $v;
        }

        $page->created_by = AdminAuth::getLoginId();
        $page->created = date('Y-m-d H:i:s');
        $page->modified = date('Y-m-d H:i:s');
        if($page->save())
        {
            if(isset($data['title']) && $data['title'])
            {
                $page->slug = Str::slug($page->title) . '-' . General::encode($page->id);
                $page->save();
            }

            return $page;
        }
        else
        {
            return null;
        }
    }

    /**
    * To update
    * @param $id
    * @param $where
    */
    public static function modify($id, $data)
    {
        $page = OrderStatusHistory::find($id);
        foreach($data as $k => $v)
        {
            $page->{$k} = $v;
        }

        $page->modified = date('Y-m-d H:i:s');
        if($page->save())
        {
            if(isset($data['title']) && $data['title'])
            {
                $page->slug = Str::slug($page->title) . '-' . General::encode($page->id);
                $page->save();
            }

            return $page;
        }
        else
        {
            return null;
        }
    }

    
    /**
    * To update all
    * @param $id
    * @param $where
    */
    public static function modifyAll($ids, $data)
    {
        if(!empty($ids))
        {
            return OrderStatusHistory::whereIn('orders.id', $ids)
                    ->update($data);
        }
        else
        {
            return null;
        }

    }

    /**
    * To delete
    * @param $id
    */
    public static function remove($id)
    {
        $page = OrderStatusHistory::find($id);
        return $page->delete();
    }

    /**
    * To delete all
    * @param $id
    * @param $where
    */
    public static function removeAll($ids)
    {
        if(!empty($ids))
        {
            return OrderStatusHistory::whereIn('orders.id', $ids)
                    ->delete();
        }
        else
        {
            return null;
        }

    }

    /**
	 * Define attributes that need to be logged.
	 */
	public function getActivitylogOptions(): LogOptions {
		return LogOptions::defaults()
			->logAll()
			->useLogName('orders');
	}
}
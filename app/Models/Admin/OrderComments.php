<?php
namespace App\Models\Admin;
use App\Models\AppModel;
use Illuminate\Http\Request;

class OrderComments extends AppModel
{
    protected $table = 'order_comments';
    protected $primaryKey = 'id';
    public $timestamps = false;
    /**
    * Trips -> Admins belongsTO relation
    * 
    * @return Admins
    */
    public function owner()
    {
        return $this->belongsTo(Admins::class, 'created_by', 'id');
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */
    public static function getListing(Request $request, $where = [])
    {
        $orderBy = $request->get('sort') ? $request->get('sort') : 'order_comments.id';
        $direction = $request->get('direction') ? $request->get('direction') : 'desc';
        $page = $request->get('page') ? $request->get('page') : 1;
        $limit = self::$paginationLimit;
        $offset = ($page - 1) * $limit;
        $listing = OrderComments::select([
                'order_comments.*',
                'owner.first_name as owner_first_name',
                'owner.last_name as owner_last_name',
                'owner.image as owner_image'
            ])
            ->leftJoin('admins as owner', 'owner.id', '=', 'order_comments.admin_id')
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
    * To get single record by id
    * @param $id
    */
    public static function get($id)
    {
        $record = OrderComments::where('id', $id)
            ->first();
        return $record;
    }

    /**
    * To get single row by conditions
    * @param $where
    * @param $orderBy
    */
    public static function getRow($where = [], $orderBy = 'order_comments.id desc')
    {
        $record = OrderComments::orderByRaw($orderBy);
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
        $driver = new OrderComments();
        foreach($data as $k => $v)
        {
            $driver->{$k} = $v;
        }
        $driver->created_by = AdminAuth::getLoginId();
        $driver->created = date('Y-m-d H:i:s');
        $driver->modified = date('Y-m-d H:i:s');
        if($driver->save())
        {
            return $driver;
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
        $driver = OrderComments::find($id);
        foreach($data as $k => $v)
        {
            $driver->{$k} = $v;
        }
        $driver->modified = date('Y-m-d H:i:s');
        if($driver->save())
        {
            return $driver;
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
            return OrderComments::whereIn('order_comments.id', $ids)
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
        $driver = OrderComments::find($id);
        return $driver->delete();
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
            return OrderComments::whereIn('order_comments.id', $ids)
                    ->delete();
        }
        else
        {
            return null;
        }
    }
}
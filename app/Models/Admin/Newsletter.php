<?php
namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;
use App\Libraries\General;

class Newsletter extends AppModel
{
    protected $table = 'newsletter';
    protected $primaryKey = 'id';
    public $timestamps = false;
    
    /**
    * Newsletter -> Admins belongsTO relation
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
        $orderBy = $request->get('sort') ? $request->get('sort') : 'newsletter.id';
        $direction = $request->get('direction') ? $request->get('direction') : 'desc';
        $page = $request->get('page') ? $request->get('page') : 1;
        $limit = self::$paginationLimit;
        $offset = ($page - 1) * $limit;
        
        $listing = NewsLetter::select([
                'newsletter.*',
                'owner.email as owner_email'
            ])
            ->leftJoin('admins as owner', 'owner.id', '=', 'newsletter.created_by')
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
    public static function getAll($select = [], $where = [], $orderBy = 'newsletter.id desc', $limit = null)
    {
        $listing = NewsLetter::orderByRaw($orderBy);

        if(!empty($select))
        {
            $listing->select($select);
        }
        else
        {
            $listing->select([
                'newsletter.*'
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
        $record = NewsLetter::where('id', $id)
            ->with([
                'owner' => function($query) {
                    $query->select([
                            'id',
                            'email'
                            
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
    public static function getRow($where = [], $orderBy = 'newsletter.id desc')
    {
        $record = NewsLetter::orderByRaw($orderBy);

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
        $newsletter = new NewsLetter();

        foreach($data as $k => $v)
        {
            $newsletter->{$k} = $v;
        }

        $newsletter->created_by = AdminAuth::getLoginId();
        $newsletter->created = date('Y-m-d H:i:s');
        $newsletter->modified = date('Y-m-d H:i:s');
        if($newsletter->save())
        {
            if(isset($data['email']) && $data['email'])
            {
                //$newsletter->slug = Str::slug($newsletter->email) . '-' . General::encode($newsletter->id);
                $newsletter->save();
            }

            return $newsletter;
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
        $newsletter = NewsLetter::find($id);
        foreach($data as $k => $v)
        {
            $newsletter->{$k} = $v;
        }

        $newsletter->modified = date('Y-m-d H:i:s');
        if($newsletter->save())
        {
            if(isset($data['email']) && $data['email'])
            {
               // $newsletter->slug = Str::slug($newsletter->email) . '-' . General::encode($newsletter->id);
                $newsletter->save();
            }

            return $newsletter;
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
            return NewsLetter::whereIn('newsletter.id', $ids)
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
        $newsletter = NewsLetter::find($id);
        return $newsletter->delete();
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
            return NewsLetter::whereIn('newsletter.id', $ids)
                    ->delete();
        }
        else
        {
            return null;
        }
    }
}
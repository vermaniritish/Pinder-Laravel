<?php
namespace App\Models\API;

use Illuminate\Http\Request;
use App\Models\AppModel;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Libraries\FileSystem;

class UsersTokens extends AppModel
{

    protected $table = 'users_tokens';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**
    * UsersToken -> Users belongsTO relation
    * 
    * @return Users
    */
    public function user()
    {
        return $this->belongsTo(Users::class, 'user_id', 'id');
    }
   
    /**
    * To get single record by id
    * @param $id
    */
    public static function get($token)
    {
        $record = UsersTokens::leftJoin('users', 'users.id', '=', 'users_tokens.user_id')
            ->where('users.status', 1)
            ->where('users_tokens.token', $token)
            ->where('users_tokens.expire_on', '>', date('Y-m-d H:i:s'))
            ->with(['user'])
            ->first();

        return $record;
    }

    /**
    * To get single record by id
    * @param $id
    */
    public static function getUserId($token)
    {
        return UsersTokens::leftJoin('users', 'users.id', '=', 'users_tokens.user_id')
            ->where('users.status', 1)
            ->where('users_tokens.token', $token)
            ->where('users_tokens.expire_on', '>', date('Y-m-d H:i:s'))
            ->pluck('users_tokens.user_id')
            ->first();
    }


    /**
    * To insert
    * @param $where
    * @param $orderBy
    */
    public static function create($data)
    {
    	$token = new UsersTokens();

    	foreach($data as $k => $v)
    	{
    		$token->{$k} = $v;
    	}

    	$token->created = date('Y-m-d H:i:s');
    	$token->modified = date('Y-m-d H:i:s');
	    if($token->save())
	    {
	    	return $token;
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
    	$token = UsersTokens::find($id);
    	foreach($data as $k => $v)
    	{
    		$token->{$k} = $v;
    	}

    	$token->modified = date('Y-m-d H:i:s');
	    if($token->save())
	    {
	    	return $token;
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
    	$token = UsersTokens::find($id);
    	return $token->delete();
    }
}
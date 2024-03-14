<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;
use Illuminate\Support\Str;
use App\Libraries\General;

class Blogs extends AppModel
{
    protected $table = 'blogs';
    protected $primaryKey = 'id';
    public $timestamps = false;

    
    /**
    * Blogs -> BlogCategories belongsToMany relation
    *
    * @return BlogCategories
    */
    public function categories()
    {
        return $this->belongsToMany(BlogCategories::class, 'blog_category_relation', 'blog_id', 'category_id');
    }

    /**
    * Get resize images
    *
    * @return array
    */
    public function getResizeImagesAttribute()
    {
        return $this->image ? FileSystem::getAllSizeImages($this->image) : null;
    }

    /**
    * Blogs -> Admins belongsTO relation
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
    	$orderBy = $request->get('sort') ? $request->get('sort') : 'blogs.id';
    	$direction = $request->get('direction') ? $request->get('direction') : 'desc';
    	$page = $request->get('page') ? $request->get('page') : 1;
    	$limit = self::$paginationLimit;
    	$offset = ($page - 1) * $limit;
    	
    	$listing = Blogs::select([
	    		'blogs.*',
                'owner.first_name as owner_first_name',
                'owner.last_name as owner_last_name'
	    	])
            ->distinct()
            ->with([
                'categories' => function($query) {
                    $query->select(['blog_categories.id', 'blog_categories.title']);
                }
            ])
            ->leftJoin('admins as owner', 'owner.id', '=', 'blogs.created_by')
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
    public static function getAll($select = [], $where = [], $orderBy = 'blogs.id desc', $limit = null)
    {
    	$listing = Blogs::orderByRaw($orderBy);

    	if(!empty($select))
    	{
    		$listing->select($select);
    	}
    	else
    	{
    		$listing->select([
    			'blogs.*'
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
    	$record = Blogs::where('id', $id)
            ->with([
                'categories' => function($query) {
                    $query->select(['blog_categories.id', 'blog_categories.title']);
                },
                'owner' => function($query) {
                    $query->select(['id', 'first_name', 'last_name']);
                },
            ])
            ->first();
            
	    return $record;
    }

    /**
    * To get single row by conditions
    * @param $where
    * @param $orderBy
    */
    public static function getRow($where = [], $orderBy = 'blogs.id desc')
    {
    	$record = Blogs::orderByRaw($orderBy);

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
    	$blog = new Blogs();

    	foreach($data as $k => $v)
    	{
    		$blog->{$k} = $v;
    	}

        $blog->created_by = AdminAuth::getLoginId();
    	$blog->created = date('Y-m-d H:i:s');
    	$blog->modified = date('Y-m-d H:i:s');
	    if($blog->save())
	    {
            if(isset($data['title']) && $data['title'])
            {
                $blog->slug = Str::slug($blog->title) . '-' . General::encode($blog->id);
                $blog->save();
            }

	    	return $blog;
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
    	$blog = Blogs::find($id);
    	foreach($data as $k => $v)
    	{
    		$blog->{$k} = $v;
    	}

    	$blog->modified = date('Y-m-d H:i:s');
	    if($blog->save())
	    {
            if(isset($data['title']) && $data['title'])
            {
                $blog->slug = Str::slug($blog->title) . '-' . General::encode($blog->id);
                $blog->save();
            }

	    	return $blog;
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
    		return Blogs::whereIn('blogs.id', $ids)
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
    	$blog = Blog::find($id);
    	return $blog->delete();
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
    		return Blogs::whereIn('blogs.id', $ids)
		    		->delete();
	    }
	    else
	    {
	    	return null;
	    }

    }

    /**
    * Save and handle categories
    * @param $id
    * @param $categories array
    */
    public static function handleCategories($id, $categories)
    {
        //Delete all first
        BlogCategoryRelation::where('blog_id', $id)->delete();
        // Then Save
        foreach($categories as $c)
        {
            $relation = new BlogCategoryRelation();
            $relation->blog_id = $id;
            $relation->category_id = $c;
            $relation->save();
        }
    }
}
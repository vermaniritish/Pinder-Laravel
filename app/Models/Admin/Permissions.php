<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;

class Permissions extends AppModel
{
    protected $table = 'permissions';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**
    * Save Permissions
    * @param $adminId
    * @param $type
    * @param $mode
    */
    public static function hasPermission($type, $mode)
    {
        
        if(AdminAuth::isAdmin())
        {
            return true;
        }
        else
        {
            $adminId = AdminAuth::getLoginId();
            $adminPermissions = AdminPermissions::select([
                'permissions.id'
            ])
            ->leftJoin('permissions', 'permissions.id', '=', 'admin_permissions.permission_id')
            ->where('admin_permissions.admin_id', $adminId)
            ->where('permissions.type', $type)
            ->where('admin_permissions.mode', $mode)
            ->limit(1)
            ->first();
            return $adminPermissions && $adminPermissions->id;
        }
    }


    /**
    * Save Permissions
    * @param Admins $adminId
    * @param $permissions
    */
    public static function savePermissions($adminId, $permissions)
    {
        AdminPermissions::where('admin_id', $adminId)->delete();
        foreach($permissions as $id => $v)
        {
            foreach($v as $mode)
            {
                $permission = new AdminPermissions();
                $permission->permission_id = $id;
                $permission->admin_id = $adminId;
                $permission->mode = $mode;
                $permission->created_by = AdminAuth::getLoginId();
                $permission->save();
            }
        }
    }

    public static function getUserPermissions($adminId)
    {
        $permissions = AdminPermissions::select([
            'permission_id',
            'mode'
        ])
        ->where('admin_id', $adminId)
        ->get();

        $finalPermissions = [];
        foreach($permissions as $k => $v)
        {
            if(!isset($finalPermissions[$v->permission_id]) || !in_array($v->mode, $finalPermissions[$v->permission_id]))
            {
                $finalPermissions[$v->permission_id][] = $v->mode;
            }
        }

        return $finalPermissions;
    }
}
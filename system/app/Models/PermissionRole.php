<?php

namespace system\Models;

// use Illuminate\Database\Eloquent\Model;
use Zizaco\Entrust\EntrustPermission;

class PermissionRole extends EntrustPermission
{
    protected $table = 'permission_role';
    protected $fillable = [
        'permission_id',
        'role_id',
        
    ];

    public function permission() {
        return $this->hasOne('system\Models\Permission');
    }
    public function role() {
        return $this->hasOne('system\Models\Role', 'id', 'role_id')
                    ->select(['id', 'name', 'display_name']);
                    
    }
}

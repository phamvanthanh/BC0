<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class RoleUser extends Model
{
    protected $table = 'role_user';
    protected $fillable = [
        'user_id',
        'role_id',
        'active'
    ];

    public function user() {
        return $this->hasOne('system\Models\User');
    }
    public function role() {
        return $this->hasOne('system\Models\Role', 'id', 'role_id')
                    ->select(['id', 'name', 'display_name']);
                    
    }
}

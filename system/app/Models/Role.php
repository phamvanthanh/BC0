<?php

 namespace system\Models;

// use Illuminate\Database\Eloquent\Model;

use Zizaco\Entrust\EntrustRole;

class Role extends EntrustRole
{
    protected $table = 'roles';
    protected $fillable = [
        'name',
        'display_name',
        'description'
    ];
    
    // public function users()
    // {
    //     return $this->belongsToMany('system\Models\User')->using('system\Models\RoleUser');
    // }
    
    


}


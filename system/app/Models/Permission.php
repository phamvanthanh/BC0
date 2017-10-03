<?php namespace system\Models;

use Zizaco\Entrust\EntrustPermission;

class Permission extends EntrustPermission
{
    protected $fillable = [
        'id',
        'name',
        'display_name',
        'description'
    ];
    
}
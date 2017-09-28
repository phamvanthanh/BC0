<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class JobHolder extends Model
{
    protected $table = 'job_holders';

    protected $fillable = [
        'job_id',
        'user_id',
        'role_id'
    ];

    public function user() {
        return $this->hasOne('system\Models\User');
    }

    public function role() {
        return $this->hasOne('system\Models\Role');
    }


}

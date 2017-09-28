<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Nation extends Model
{
    protected $table = 'nations';
    protected $fillable = [
        'name',
        'abbreviation',
        'created_by'
    ];
    
    
    public function user(){
        return $this->hasOne('User');
    }
    public function project(){
        return $this->hasOne('Project');
    }
}

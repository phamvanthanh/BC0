<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Industry extends Model
{
    protected $table = 'industry';
    protected $fillable = [
        'name',
        'discription'
    ];
    public function project(){
        return $this->hasOne('Project');
    } 
}

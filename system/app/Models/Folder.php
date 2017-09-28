<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Folder extends Model
{
    protected $table = 'folders';
    protected $fillable = [
        'project_id',
        'name',

    ];
    public function project(){
        return $this->belongsTo('Project');
    }
}

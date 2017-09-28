<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Link extends Model
{
    protected $table = 'links';
    protected $fillable = [
        'project_id',
        'url',
        'caption',
        'note'
    ];
    public function project(){
        return $this->belongsTo('Project');
    }

}

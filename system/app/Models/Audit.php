<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Audit extends Model
{
    protected $table = 'audit';
    protected $fillable = [
        'quantity_id',       
        'quantity',
        'commit'
    ];

    public function quantity(){
        return $this->belongsTo('system\Models\Quantity');
    }
    
    public function file(){
        return $this->hasOne('system\Models\AuditFile');
    }
    public function markdown(){
         return $this->hasOne('system\Models\AuditMarkdwon');
    }

}

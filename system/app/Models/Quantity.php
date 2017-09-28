<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Quantity extends Model
{
    protected $table = 'quantity';
    protected $fillable = [
        'job_id',
        'code',
        'quantity',
        'file',
        'path',
        'markdown',
        'commit'
    ];
    public function audit(){
        return $this->hasOne('system\Models\Audit');
    }
    public function file(){
        return $this->hasOne('system\Models\QuantityFile');
    }
    public function markdown() {
         return $this->hasOne('system\Models\QuantityMarkdwon');
    }
}

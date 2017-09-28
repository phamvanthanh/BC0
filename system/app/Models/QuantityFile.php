<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class QuantityFile extends Model
{
    protected $table = 'quantity_files';
    protected $fillable = [
        'quantity_id',
        'name',
        'path',
        'type',
        'created_at',
        'updated_at'
    ];

    public function quantity()
    {
        return $this->belongsTo('system\Models\Quantity');
    }
}

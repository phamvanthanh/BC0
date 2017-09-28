<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class QuantityMarkdown extends Model
{
    protected $table = 'quantity_markdowns';
    protected $fillable = [
        'quantity_id',
        'name',
        'path',

    ];

    public function quantity()
    {
        return $this->belongsTo('system\Models\Quantity');
    }
}

<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Swbs extends Model
{
    protected $table = 'swbs';
    protected $fillable = [
        'section_id',
        'code'
    ];
}

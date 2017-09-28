<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Gwbs extends Model
{
    protected $table = 'gwbs';
    protected $fillable = [
        'section_id',
        'code'
    ];
}

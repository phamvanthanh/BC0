<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Form extends Model
{
    protected $table = 'forms';

    protected $fillable = [
        'id',
        'code',
        'name',
        'path'
    ];
}

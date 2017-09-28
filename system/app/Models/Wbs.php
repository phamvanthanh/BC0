<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Wbs extends Model
{
    protected $table = 'wbs';
    protected $fillable = [
        'code',
        'parent_code',
        'name',
        'description',
        'status',
        'extension',
        'quantitfy'

    ];
}

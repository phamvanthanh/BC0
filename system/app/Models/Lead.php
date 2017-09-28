<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Lead extends Model
{
    protected $table='leads';
    protected $fillable = [
        'id',
        'first_name',
        'last_name',
        'email',
        'phone',
        'company',
        'subscription',
        'message'

    ];
}

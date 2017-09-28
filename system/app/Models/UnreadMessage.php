<?php

namespace Snail\Models;

use Illuminate\Database\Eloquent\Model;

class UnreadMessage extends Model
{
    protected $table = 'unreads';
    
    protected $fillable = [
        'message_id',
        'job_id'
    ];
}

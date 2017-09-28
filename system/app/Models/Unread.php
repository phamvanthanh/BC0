<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Unread extends Model
{
     protected $table = 'unreads';
    
     protected $fillable = [
        'message_id',
        'job_id'
     ];
}

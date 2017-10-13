<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    protected $table = 'messages';
    protected $fillable = [
        'id',
        'sender_id',
        'message',
        'parent_message_id'
    ];
}

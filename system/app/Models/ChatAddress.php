<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class ChatAddress extends Model
{
    protected $table = 'chat_addresses';
    protected $fillable = [
        'sender_id',
        'recipient_id'
    ];
}

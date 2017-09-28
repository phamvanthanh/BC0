<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    protected $table = 'messages';

    protected $fillable = [
      
        'user_id',
        'message'
    ];


    public function jobs() {
        return $this->belongsTo('system\Models\JobMessage', 'id', 'message_id');
    }
}

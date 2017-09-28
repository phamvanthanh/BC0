<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Bid extends Model
{
    protected $table = 'bids';
    protected $fillable = [
        'job_id',
        'user_id',
        'status'
    ];

    public function job() {
        return $this->belongsTo('system\Models\Job');
    }

    public function user() {
        return $this->belongsTo('system\Models\User')
                    ->with('activeawards')
                    ->select(['id', 'first_name', 'last_name', 'email']);
    }
   
}

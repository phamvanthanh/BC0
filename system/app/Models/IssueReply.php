<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class IssueReply extends Model
{
    protected $table = 'issue_replies';

    protected $fillable = [
        'issue_id',
        'job_id',
        'user_id',
        'reply'
    ];

    public function user() {
        return $this->belongsTo('system\Models\User');
    }

    public function job() {
        return $this->belongsTo('system\Models\Job')
                    ->with('jobable');
    }

    public function files() {
        return $this->hasMany('system\Models\IssueFile', 'id', 'reply_id');
                
    }
}

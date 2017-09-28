<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Issue extends Model
{
    protected $table = 'issues';
    protected $fillable = [
        'user_id',
        'job_id',
        'title',
        'description',
        'status'

    ];

    public function replies() {

         return $this->hasMany('system\Models\IssueReply')
                     ->with('job');                                                               
                   
    }

    public function job() {

        return $this->belongsTo('system\Models\Job')
                    ->with('jobable');
    }

    public function user() {
        return $this->belongsTo('system\Models\User');
    }

    public function files() {
        return $this->hasMany('system\Models\IssueFiles');
    }
}

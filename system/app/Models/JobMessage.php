<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class JobMessage extends Model
{
    protected $table = 'job_message';
    protected $fillable = [
        'from_job_id',
        'to_job_id',
        'message_id',
        'private',
        'unread'
    ];

    public function message() {
        return $this->hasOne('\system\Models\Message', 'id', 'message_id');
    }

    public function fromjob() {
        return $this->hasOne('\system\Models\Job', 'id', 'from_job_id')
                    ->with('jobable');
    }

    public function tojob() {
        return $this->hasOne('\system\Models\Job', 'id', 'to_job_id');
                   
    }

}

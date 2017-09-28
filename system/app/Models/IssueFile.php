<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class IssueFile extends Model
{
    protected $table = 'issue_files';

    protected $fillable = [
        'issue_id',
        'reply_id',
        'name',
        'path',

    ];
}

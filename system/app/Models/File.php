<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class File extends Model
{
    protected $table="files";
    protected $fillable = [
        'folder_id',
        'path',
        'name',
        'revision',
        'status'
    ];
}

<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class AuditFile extends Model
{
    protected $table = 'audit_files';
    protected $fillable = [
        'audit_id',
        'name',
        'path',
        'created_by'
    ];

    public function audit()
    {
        return $this->belongsTo('system\Models\Audit');
    }
}

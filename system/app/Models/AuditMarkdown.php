<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class AuditMarkdown extends Model
{
    protected $table = 'audit_markdowns';
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

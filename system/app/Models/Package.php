<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Package extends Model
{
    protected $table = 'packages';
    protected $fillable = [
        'section_id',
        'name',
        'area',
        'complexity',
        'description'
    ];

    public function section()
    {
        return $this->belongsTo('system\Models\Section')
                    ->with('job')
                    ->with('itemNum')
                    ->with('project')                                  
                    ->select(['id', 'project_id', 'name']);
    }
    public function job() {
        return $this->morphOne('system\Models\Job', 'jobable')
                    ->with('jobable')
                    ->with('awarded')
                    ->select(['id', 'jobable_id', 'jobable_type', 'from_date', 'to_date', 'rate', 'comment', 'status']);                    
    }
   

   
}

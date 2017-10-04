<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;
 

class Project extends Model
{
    protected $table = 'projects'; 
    protected $fillable = [
        'jid', 
        'name', 
        'industry_id', 
        'nation_abbr',  
        'user_id',
        'from_date', 
        'to_date',       
        'description', 
        'requirement', 
      
    ];  
    public function nation() {
        return $this->belongsTo('system\Models\Nation', 'nation_abbr', 'abbr');
    }

    public function user() {
        return $this->belongsTo('system\Models\User')
                    ->select(['id', 'first_name', 'last_name'], 'id', 'user_id');
    }

    public function industry() {
        return $this->belongsTo('system\Models\Industry')
                    ->select(['id', 'name']);
    }

    public function link() {
        return $this->hasOne('system\Models\Link');
    }

    public function folder() {
        return $this->hasOne('system\Models\Folder');
    }  

    public function job() {
        return $this->morphOne('system\Models\Job', 'jobable')
                    ->with('jobable')
                    ->with('awarded')
                    ->select(['id', 'jobable_id', 'jobable_type', 'from_date', 'rate', 'comment', 'to_date', 'status']);
                    
    }

    public function section() {
        return $this->hasOne('system\Models\Section')
                    ->with('packages');
    }

    public function packages() {
        return $this->hasManyThrough('system\Models\Package', 'system\Models\Section')
                    ->with('job');
    }
    
}

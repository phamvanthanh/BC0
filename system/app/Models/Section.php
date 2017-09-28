<?php

namespace system\Models;

use Illuminate\Database\Eloquent\Model;

class Section extends Model
{
    protected $table = 'sections';
    protected $fillable = [
        'project_id',
        'name',
        'description'
    ];
    public function project() {
        return $this->belongsTo('system\Models\Project')
                    ->with('industry')
                    ->with('nation')
                    ->with('job')
                    ->select(['id', 'name', 'industry_id', 'nation_id', 'user_id', 'requirement', 'description', 'created_at', 'updated_at', 'created_by']);
    }
    public function packages() {

        return $this->hasMany('system\Models\Package')
                    ->with('job');
    }
    public function job() {

        return $this->morphOne('system\Models\Job', 'jobable')
                    ->with('jobable')
                    ->with('awarded')
                    ->select(['id', 'jobable_id', 'jobable_type', 'from_date', 'to_date', 'rate', 'comment', 'status']);
    }
    public function itemNum() {
        
         $item = $this->hasMany('system\Models\Gwbs')                   
                     ->selectRaw('group_id, count(*) as count')
                     ->groupBy('group_id')
                     ;
        return $item;                
    }
}

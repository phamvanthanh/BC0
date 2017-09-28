<?php

namespace Snail\Models;

use Illuminate\Database\Eloquent\Model;

class Group extends Model
{
    protected $table = 'groups';
    protected $fillable = [
        'project_id',
        'name',
        'description'
    ];
    public function project() {
        return $this->belongsTo('Snail\Models\Project')
                    ->with('industry')
                    ->with('nation')
                    ->with('job')
                    ->select(['id', 'name', 'industry_id', 'nation_id', 'user_id', 'requirement', 'description', 'created_at', 'updated_at', 'created_by']);
    }
    public function packages()
    {
        return $this->hasMany('Snail\Models\Package');
    }
    public function job()
    {
        return $this->morphOne('Snail\Models\Job', 'jobable')
                    ->with('awarded')
                    ->select(['id', 'jobable_id', 'from_date', 'to_date', 'status']);
    }
    public function itemNum() {
         $item = $this->hasMany('Snail\Models\Gwbs')                   
                     ->selectRaw('group_id, count(*) as count')
                     ->groupBy('group_id')
                     ;

        
       // $item =  (array) $item;
        return $item;                
    }
}

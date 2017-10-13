<?php

namespace system\Models;


use Illuminate\Database\Eloquent\Model;

use system\Models\Section;
use system\Models\Package;
use system\Models\Role;

class Job extends Model
{
    protected $table = 'jobs';
    protected $fillable = [
        'jobable_id',
        'jobable_type',
        'jobable_name',
        'role_id',
        'from_date',
        'to_date',        
        'status',
        'comment',
        'rate'
    ];
    
    public function jobable()
    {
        return $this->morphTo();
    }
    public function bids() {
        return $this->hasMany('system\Models\Bid')
                    ->with('user');
    }
    public function awarded() {
        return $this->hasOne('system\Models\Bid')
                    ->where('status', 'awarded')
                    ->with('user')                  
                    ->select(['id', 'job_id', 'user_id', 'created_at', 'updated_at']);
    }

    public function holders() {
        return $this->hasMany('system\Models\JobHolder');
    }

    
    public function role() {
        $name = '';
        switch($this->jobable_type){

            case 'package':
                $name = 'surveyor';
                break;

            case 'section':
                $name = 'controller';
                break;

            case 'project':
                $name = 'manager';
                break;
            default:
                break;
                
        }
        return Role::where('name', $name);
    }

    public function relatedJobs() {
       

        $relatedJobs = array();

        switch($this->jobable_type) {
            case 'package':

                $group_job   = Job::with('jobable')
                                  ->where('jobable_id', $this->jobable['section_id'])
                                  ->where('jobable_type', 'section')
                                  ->first();

                $project_job = Job::where('jobable_id', $group_job->jobable['project_id'])
                                  ->where('jobable_type', 'project')
                                  ->with('jobable')
                                  ->first();

                array_push($relatedJobs,  $group_job, $project_job);
                
                break;

            case 'section': 
                $project_job = Job::with('jobable')
                                  ->where('jobable_id', $this->jobable['project_id'])
                                  ->where('jobable_type', 'project')
                                  ->first();
                $packages = Package::with('job')
                                  ->where('section_id', $this->jobable_id)
                                  ->get();
                $collect = collect($packages)->pluck('job')->all();

                array_push($relatedJobs,  $project_job);

                $relatedJobs = array_merge($relatedJobs, $collect);

                break;
            
            case 'project':
                               
                $groups = Section::with('job')
                                  ->where('project_id', $this->jobable_id)
                                  ->get();
                $collect = collect($groups)->pluck('job')->all();              

                $relatedJobs = array_merge($relatedJobs, $collect);

                foreach($groups as $group) {
                    $packages = Package::with('job')
                                  ->where('section_id', $group->id)
                                  ->get();

                    $collect = collect($packages)->pluck('job')->all();
                    
                    $relatedJobs = array_merge($relatedJobs, $collect);
                }
                break;

            default:
                break;
               
        }       
        
        return $relatedJobs;



    }
    
}


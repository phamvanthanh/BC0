<?php

namespace system\Http\Controllers\Utilities;

use Illuminate\Http\Request;
use system\Http\Controllers\Controller;
use DB;

class ProjectUti extends Controller
{
     public function countActiveProjects() {  
        
        return DB::table('projects')
                ->join('jobs', function($q){
                    $q->on('projects.id', '=', 'jobs.jobable_id')
                      ->where('jobs.jobable_type', 'project');
                })
                ->where('jobs.status', 'active')
                ->count();
      
    }

    public function countAllProjects() {       
        return DB::table('projects')
                 ->count();

    }

    public function countFinishedProjects() {       
         return DB::table('projects')
                    ->join('jobs', function($q){
                        $q->on('projects.id', '=', 'jobs.jobable_id')
                          ->where('jobs.jobable_type', 'project');
                    })
                    ->where('jobs.status', 'finished')
                    ->count();
    } 
    public function countUnwardedProjects() {
        return DB::table('projects')
                 ->join('jobs', function($q){
                        $q->on('projects.id', '=', 'jobs.jobable_id')
                            ->where('jobs.jobable_type', 'project');
                   })
                 ->join('bids', 'jobs.id', '=', 'bids.job_id') 
                 ->where('bids.status', 'awarded')
                 ->count();
    }
}

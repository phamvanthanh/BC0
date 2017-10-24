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
                 ->where('bids.status',  'awarded')
                 ->count();
    }

    public function countNewProjects(Request $request) {
        
        if(!$request['days'])
            $period = 7; // 7 days
        else
            $period = $request['days'];

        $date = new \DateTime;

        $date->modify('-'.$period.' days');
        $formatted_date = $date->format('Y-m-d H:i:s');

        return DB::table('projects')
                 ->where('created_at', '>=', $formatted_date)
                 ->count();

    }
    public function newProjects($request) {
        if(!$request['days'])
            $period = 7; // 7 days
        else
            $period = $request['days'];

        $date = new \DateTime;

        $date->modify('-'.$period.' days');
        $formatted_date = $date->format('Y-m-d H:i:s');

        return DB::table('projects')
                 ->join('jobs', 'projects.id', 'jobs.jobable_id')
                 ->where('projects.created_at', '>=', $formatted_date)
                 ->select(DB::raw(
                      'projects.id',
                      'projects.name',
                      'projects.nation_abbr',
                      'projects.industry',
                      'jobs.from_date',
                      'jobs.to_date'
                 ))
                 ->get()
                 ->toArray();
    }

}

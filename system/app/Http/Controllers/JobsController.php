<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use system\Models\Bid;
use system\Models\Job;
use system\Models\Project;
use system\Models\Section;
use system\Models\Package;
use system\Http\Requests\JobForm;
use DB;

class JobsController extends Controller
{
    /**
    * @return system\Models\Job
    * Return all jobs
    */
    public function index(Request $request) {

        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';

        $dropTempTables = DB::unprepared(
            DB::raw("
                DROP TABLE IF EXISTS vpackages;    
                DROP TABLE IF EXISTS vbids;     
                           
            ")
        );
        $vpackages = DB::unprepared( DB::raw(
                        'CREATE TEMPORARY TABLE vpackages
                            AS (select packages.id, packages.name, sections.project_id from packages
                            JOIN sections
                            ON packages.section_id = sections.id);

                        CREATE TEMPORARY TABLE vbids
                            AS (select jobs.id, COUNT(bids.job_id) as count from bids
                            JOIN jobs
                            ON jobs.id = bids.job_id
                            GROUP BY id);                 
                        
                        ') 
                     ); 
         if($vpackages)

         return DB::table('jobs')
           ->LeftJoin('projects', function($join){
               $join->on('jobs.jobable_id', '=', 'projects.id');
               $join->where('jobs.jobable_type', '=', 'project');
           })
           ->LeftJoin('sections', function($join){
               $join->on('jobs.jobable_id', '=', 'sections.id');
               $join->where('jobs.jobable_type', '=', 'section');
           })      
           ->leftJoin('vpackages' , function($join){
               return $join->on('jobs.jobable_id', '=', 'vpackages.id')
                           ->where('jobs.jobable_type', '=', 'package');
           })
           ->Join('projects as p', function($join) {
               $join->on('projects.id', '=', 'p.id')
                    ->orOn('sections.project_id', '=', 'p.id')
                    ->orOn('vpackages.project_id', '=', 'p.id');                  
                            
               
            })
            ->leftJoin('bids', function($join){
                return $join->on('jobs.id', '=', 'bids.job_id')
                            ->where('bids.status', '=', 'awarded');
            })
            ->leftJoin('vbids', 'jobs.id', '=', 'vbids.id')
            ->select(DB::raw('
                jobs.id,
                jobs.jobable_type,
                jobs.jobable_id,
                jobs.from_date,
                jobs.to_date,
                jobs.status,
                    IF(jobs.jobable_type = "project", projects.name,
                    IF(jobs.jobable_type = "section", sections.name, vpackages.name) 
                ) as name,
                p.name as project,
                p.nation_abbr as nation_abbr,
                vbids.count as bid_count,
                bids.status as bid_status
     
           '
               
           ))
           ->where('jobs.id', 'LIKE', "%{$query}%")
           ->orWhere('jobs.jobable_type', 'LIKE', "%{$query}%")
           ->orWhere('jobs.from_date', 'LIKE', "%{$query}%")
           ->orWhere('jobs.to_date', 'LIKE', "%{$query}%")
           ->orWhere('p.name', 'LIKE', "%{$query}%")
           ->orWhere('projects.name', 'LIKE', "%{$query}%")
           ->orWhere('sections.name', 'LIKE', "%{$query}%")
           ->orWhere('vpackages.name', 'LIKE', "%{$query}%")
           ->orderBy($orderBy, $ascending)
           ->paginate($limit);
        
    }

    
    /**
    * @return system\Models\Job
    * Return all active jobs
    */
    public function availJobs(Request $request) {

        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';

        $dropTempTables = DB::unprepared(
            DB::raw("
                DROP TABLE IF EXISTS vpackages;    
                DROP TABLE IF EXISTS vbids;     
                           
            ")
        );
        $vpackages = DB::unprepared( DB::raw(
                        'CREATE TEMPORARY TABLE vpackages
                            AS (select packages.id, packages.name, sections.project_id from packages
                            JOIN sections
                            ON packages.section_id = sections.id);

                        CREATE TEMPORARY TABLE vbids
                            AS (select jobs.id, COUNT(bids.job_id) as count from bids
                            JOIN jobs
                            ON jobs.id = bids.job_id
                            GROUP BY id);                 
                        
                        ') 
                     ); 
         if($vpackages)

         return DB::table('jobs')
           ->LeftJoin('projects', function($join){
               $join->on('jobs.jobable_id', '=', 'projects.id')
                    ->where('jobs.jobable_type', '=', 'project');
           })
           ->LeftJoin('sections', function($join){
               $join->on('jobs.jobable_id', '=', 'sections.id')
                    ->where('jobs.jobable_type', '=', 'section');
           })      
           ->leftJoin('vpackages' , function($join){
               return $join->on('jobs.jobable_id', '=', 'vpackages.id')
                           ->where('jobs.jobable_type', '=', 'package');
           })
           ->Join('projects as p', function($join) {
               $join->on('projects.id', '=', 'p.id')
                    ->orOn('sections.project_id', '=', 'p.id')
                    ->orOn('vpackages.project_id', '=', 'p.id');                  
            })
            ->leftJoin('bids', function($join){
                return $join->on('jobs.id', '=', 'bids.job_id')
                            ->where('bids.status', '=', 'awarded');
            })
            ->leftJoin('vbids', 'jobs.id', '=', 'vbids.id')
            ->select(DB::raw('
                jobs.id,
                jobs.jobable_type,
                jobs.jobable_id,
                jobs.from_date,
                jobs.to_date,
                jobs.status,
                    IF(jobs.jobable_type = "project", projects.name,
                    IF(jobs.jobable_type = "section", sections.name, vpackages.name) 
                ) as name,
                p.name as project,
                p.nation_abbr as nation_abbr,
                vbids.count as bid_count,
                bids.status as bid_status     
             '               
           ))
           ->where('jobs.status', '=', 'active')
           ->where(function($q){
               return $q->whereNull('bids.status')
                        ->orWhere('bids.status', '=', 'withhold');
           })       
           
           ->where(function($q) use($query){
                    return $q->where('jobs.id', 'LIKE', "%{$query}%")
                    ->orWhere('jobs.jobable_type', 'LIKE', "%{$query}%")
                    ->orWhere('jobs.from_date', 'LIKE', "%{$query}%")
                    ->orWhere('jobs.to_date', 'LIKE', "%{$query}%")
                    ->orWhere('p.name', 'LIKE', "%{$query}%")
                    ->orWhere('projects.name', 'LIKE', "%{$query}%")
                    ->orWhere('sections.name', 'LIKE', "%{$query}%")
                    ->orWhere('vpackages.name', 'LIKE', "%{$query}%");
            })   
                   
           ->orderBy($orderBy, $ascending)
           ->paginate($limit);


        //  $jobs = Job::where('status', 'active')                                  
                  
        //             ->whereDoesntHave('bids', function($query){
        //                $query->where('status', 'like', 'awarded');
        //             })                  
        //             ->get();  
        //  foreach($jobs as $index=>$job) {
        //      $jobs[$index]['info'] = $this->info($job['id']);
        //  }
        //  return $jobs;
    }


    /**
    * @return system\Models\Job
    * Return all user's awarded jobs if user is not client
    */
    public function jobs(Request $request) {

        $user = Auth::user();
        
        if(!$user->hasRole('client')) {

           /**
            * Get user awarded bids.
            *
            * @return Bid
            */

            $awards = Bid::where('user_id', $user->id)->where('status', 'awarded')->get();
        
            //
            foreach($awards as $index=>$award) {
                /**
                * Attach info to each warded bids (Job with Project).
                *
                * @return Job + Project
                */
                $awards[$index]['info'] = $this->info($award->job_id);
                
                 /**
                * Find related jobs for each jobs.
                *
                * @return Job + Project
                */
                $relateds =  $awards[$index]['info']->find($award->job_id)->relatedJobs();
                
                // $collect  = collect($relateds )->pluck('id')->all();  

                                 /**
                * Attached related job id(s) to awarded bids.
                *
                * @return Job + Project
                */
                $awards[$index]['relateds'] = $relateds;
            }
            return $awards;
        }   

        $projects  = Project::where('user_id', $user->id)
                             ->with('job')
                             ->get();
        return $projects;

    }
    
    /**
    * @return system\Models\Job
    * Return all user's awarded and withhold jobs 
    */
    public function jobsByUser($id) {
       $bids = Bid::with('job')
           ->where('user_id', $id)
           ->where(function($query){
               $query->where('status', 'awarded')
                     ->orWhere('status', 'withhold');
           })
           ->get();
       ;
         foreach($bids as $index=>$bid) {

             $bids[$index]->job['info'] = $this->info($bids[$index]->job['id']);
         }
         return $bids;   
       

    }

    /**
    * @var system\Http\Requests\JobForm
    * Rate a job 
    */
    public function rateJob(JobForm $form) {
        return $form->rate();
    }

    //Get  information for a specfific job based on job_id
    public function awardedInfo($id) {
       
        $job = Job::with('jobable')->with('awarded')->find($id);
     
        if($job)  {
            switch($job['jobable_type'])
            {
                case 'package':                      
                    $project = Section::with('project')->find($job['jobable']['section_id'])['project'];
                    break;                
                case 'section': 
                     $project = Project::with('industry')->find($job['jobable']['project_id']);
                     break; 
                case 'project':             
                    $project = Project::with('industry')->find($job['jobable_id']);
                    break;  
                default:
                    break;

            }
        }
        $job['project'] = $project;
        return $job;
        
    }
    
    public function info($id) {
        
        $job = Job::with('jobable')->with('bids')->with('awarded')->find($id);

        if($job)  {
            switch($job['jobable_type'])
            {
                case 'package':                      
                    $project = Section::with('project')->find($job['jobable']['section_id'])['project'];
                    break;                
                case 'section': 
                    $project = Project::with('industry')->with('nation')->find($job['jobable']['project_id']);
                     break; 
                case 'project':             
                    $project = Project::with('industry')->with('nation')->find($job['jobable_id']);
                    break;  
                default:
                    break;

            }
        }
        $job['project'] = $project;
        return $job;
        
    }

    //Geet job wbs based job_id
    public function jwbs($id) {

        $job = Job::with('jobable')->find($id);
        $jwbs = null;
        if($job)  {
            
            switch($job['jobable_type'])
            {
                 case 'package':
                    $Pk = new SwbsController;
                    $jwbs = $Pk->index($job['jobable']['section_id']);  
                    break;              
                case 'section':
                    $G = new SwbsController;
                    $jwbs = $G->index($job['jobable']['id']); 
                    break;
                case 'project':
                    $P = new PwbsController;
                    $jwbs = $P->index($job['jobable']['id']);  
                    break;               
                default:
                    break;
            }
            
        }
        return $jwbs;
    }
}

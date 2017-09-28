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

class JobsController extends Controller
{
    /**
    * @return system\Models\Job
    * Return all jobs
    */
    public function index() {
         $jobs = Job::all();  
                  
         foreach($jobs as $index=>$job) {

             $jobs[$index]['info'] = $this->info($job['id']);
         }
         return $jobs;       
    }

    
    /**
    * @return system\Models\Job
    * Return all active jobs
    */
    public function availJobs() {

         $jobs = Job::where('status', 'active')                                  
                  
                    ->whereDoesntHave('bids', function($query){
                       $query->where('status', 'like', 'awarded');
                    })                  
                    ->get();  
         foreach($jobs as $index=>$job) {
             $jobs[$index]['info'] = $this->info($job['id']);
         }
         return $jobs;
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
                    $Pk = new GwbsController;
                    $jwbs = $Pk->index($job['jobable']['section_id']);  
                    break;              
                case 'section':
                    $G = new GwbsController;
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

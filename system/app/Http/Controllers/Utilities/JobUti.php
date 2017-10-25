<?php

namespace system\Http\Controllers\Utilities;

use Illuminate\Http\Request;
use system\Http\Controllers\Controller;
use DB;

class JobUti extends Controller
{
     public function countActiveJobs() {  
        
        return DB::table('jobs')                
                 ->where('status', 'active')
                 ->count();
      
    }

    public function countAllJobs() {       
        return DB::table('jobs')
                 ->count();

    }

    public function countFinishedJobs() {       
         return DB::table('jobs')                
                  ->where('status', 'finished')
                  ->count();
    } 
    
    public function countUnwardedJobs() {
       return  DB::table('jobs')             
                 ->join('bids', 'jobs.id', '=', 'bids.job_id') 
                 ->where('bids.status',  'awarded')
                 ->count();        
    }

    public function countNewJobs($request) {

        if(!$request['days'])
            $period = 7; // 7 days
        else
            $period = $request['days'];

        $date = new \DateTime;
        $date->modify('-'.$period.' days');
        $formatted_date = $date->format('Y-m-d H:i:s');       
       
        return DB::table('jobs')
                 ->where('created_at', '>=', $formatted_date)
                 ->count();
                

    }
    
    public function countJobItems() {

    }
    public function newJobs($request) {
        if(!$request['days'])
            $period = 7; // 7 days
        else
            $period = $request['days'];

        $date = new \DateTime;
       
        $date->modify('-'.$period.' days');
        $formatted_date = $date->format('Y-m-d H:i:s');       
   
        return DB::table('jobs')
                 ->where('user_id', NULL)
                 ->where('updated_at', '>=', $formatted_date)
                 ->where('status',  'active')
                 ->orderBy('updated_at', 'DESC')
                 ->get();
    }
}

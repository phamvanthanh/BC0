<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Issue;
use system\Models\Job;
use system\Http\Requests\IssueForm;
use Illuminate\Support\Facades\Auth;

class IssuesController extends Controller
{
    public function index($id)  { // params job id

        // return Issue::where('job_id', $id)
        //             ->with('job')                
        //             ->get();    

        $user = Auth::user();

        if(!$user->hasRole('client')) {

            $jobs = Job::with('jobable')->find($id)->relatedJobs();

            $collect  = collect($jobs)->pluck('id')->all();   
            array_push($collect, $id);   
            
            $issues = Issue::with('job')
                            ->whereIn('job_id', $collect)
                            ->orderBy('created_at', 'asc')
                            ->get();  
            
            return $issues;
        }
        

        $issues = Issue::with('job')
                        ->where('job_id', $id)
                        ->orderBy('created_at', 'asc')
                        ->get();

    
        return $issues;


    } 

    public function show($id) { // param issue imagefontwidth

        return Issue::with('replies')
                    ->with('job')                   
                    ->find($id);
    }

    public function store(IssueForm $form) {
        
        return $form->persist();
    }

    public function deleteFile(Request $request) {
       
        $url = $request['url'];
        if(file_exists($url))
            unlink($url);  
        else
            return response(['File not found'], 404);
    }
}

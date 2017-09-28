<?php

namespace system\Http\Controllers;
use system\Models\Project;
use Illuminate\Http\Request;
use system\Http\Requests\ProjectForm;
use system\Models\Job;

class ProjectsController extends Controller
{
   
    public function index() {  

        return Project::with('user')->with('nation')->with('industry')->with('job')->get();                
    }

    public function show($pid) {       
        return Project::with('user')->with('nation')->with('industry')->with('job')->find($pid);       
    }  

    public function getProjectsByClient(Request $request) {
        $user_id = $request->user()->id;
        return Project::with('job')
                      ->with('nation')
                      ->with('industry')
                      ->where('user_id', $user_id)->get();
    }

    public function store(ProjectForm $form) {
        return $form->persist();       
    }

    public function delete(Request $request) {
        Job::where('jobable_id', $request['id'])->where('jobable_type', 'project')->delete();
        Project::find($request['id'])->delete();
        return;
    }
    
    
     
}

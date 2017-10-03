<?php

namespace system\Http\Controllers;
use system\Models\Project;
use Illuminate\Http\Request;
use system\Http\Requests\ProjectForm;
use system\Models\Job;
use DB;

class ProjectsController extends Controller
{
   
    public function index(Request $request) {  

        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';
        if($orderBy == 'client') 
            $orderBy = 'first_name';           
        
        
        // return Project::with('user')->with('nation')->with('industry')->with('job')->get();
        return DB::table('projects')
                ->leftJoin('users', 'projects.user_id', '=', 'users.id')
                ->leftJoin('nations', 'projects.nation_abbr', '=', 'nations.abbr')
                ->leftJoin('industry', 'projects.industry_id', '=', 'industry.id')
                ->join('jobs', function($join){
                    $join->on('projects.id', '=', 'jobs.jobable_id')
                        ->where('jobs.jobable_type', '=', 'project');
                })
                ->select(DB::raw('
                        projects.id,
                        projects.name,
                        jobs.from_date,
                        jobs.to_date,
                        jobs.status,
                        jobs.rate,
                        CONCAT(users.first_name, " ", users.last_name) as client,
                        nations.abbr as nation_abbr,
                        industry.name as industry
                            
                '))
                ->orWhere('projects.id', 'LIKE', "%{$query}%")
                ->orWhere('projects.name', 'LIKE',"%{$query}%")
                ->orWhere(DB::raw('CONCAT(users.first_name, " ", users.last_name)'), 'LIKE',"%{$query}%")
                ->orWhere('jobs.from_date', 'LIKE',"%{$query}%")
                ->orWhere('jobs.to_date', 'LIKE', "%{$query}%")
                ->orWhere('jobs.status', 'LIKE', "%{$query}%")
                ->orWhere('nations.abbr', 'LIKE', "%{$query}%")
                ->orWhere('industry.name', 'LIKE', "%{$query}%")
                ->orderBy($orderBy, $ascending)
                ->paginate($limit);
       
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

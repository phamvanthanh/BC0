<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Controllers\Utilities\ProjectUti;
use system\Http\Controllers\Utilities\JobUti;
use system\Http\Controllers\Utilities\ClientUti;
use system\Http\Controllers\Utilities\LeadUti;
use system\Http\Controllers\Utilities\IssueUti;

class DashBoardController extends Controller
{
    public function countProjects(Request $request)  {
        
        $projectUti = new ProjectUti;
        $count = [
            'actives'  => $projectUti->countActiveProjects(),
            'awardeds' => $projectUti->countUnwardedProjects(),
            'finishes' => $projectUti->countFinishedProjects(),
            'new'      => $projectUti->countNewProjects($request),
            'all'      => $projectUti->countAllProjects()
            
        ];
        return $count;
    }

    public function countJobs(Request $request) {
        
        $jobUti = new JobUti;
        $count = [
            'actives'  => $jobUti->countActiveJobs(),
            'new' => $jobUti->countNewJobs($request),
            'awardeds' => $jobUti->countUnwardedJobs(),
            'finishes' => $jobUti->countFinishedJobs(),
            'all'      => $jobUti->countAllJobs()
            
        ];
        return $count;

    }

    public function countClients(Request $request) {
        $clientUti = new ClientUti;
        $count = [
           
            'new' => $clientUti->countNewClients($request),
            'all' => $clientUti->countAllClients()
            
        ];
        return $count;

    }
    public function countLeads(Request $request) {
        $leadUti = new LeadUti;
        $count = [
            
            'new' => $leadUti->countAllLeads(),
            'all' => $leadUti->countNewLeads($request)
            
        ];
        return $count;

    }
    public function countIssues(Request $request) {
        $issueUti = new IssueUti;
        $count = [
            
            'all' => $issueUti->countIssues(),
            'opens' => $issueUti->countOpenIssues($request)
            
        ];
        return $count;

    }

    public function newJobs(Request $request) {
        
        $jobUti = new JobUti;
        
        return $jobUti->newJobs($request);

    }

     public function newProjects(Request $request) {
        
        $projectUti = new ProjectUti;
        
        return $projectUti->newProjects($request);

    }
}

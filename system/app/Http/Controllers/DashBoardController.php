<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Controllers\Utilities\ProjectUti;

class DashBoardController extends Controller
{
    public function countProjects()  {
        
        $projectUti = new ProjectUti;
        $count = [
            'actives'  => $projectUti->countActiveProjects(),
            'awardeds' => $projectUti->countUnwardedProjects(),
            'finishes' => $projectUti->countFinishedProjects(),
            'all'      => $projectUti->countAllProjects()
            
        ];
        return $count;
    }
}

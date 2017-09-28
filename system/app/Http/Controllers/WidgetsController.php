<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;

use system\Models\Project;

class WidgetsController extends Controller
{
    public function clientProjects($uid) {
        $projects = Project::where('user_id', $uid)
                           ->with('job')
                           ->get();

        return $projects;
    }
}

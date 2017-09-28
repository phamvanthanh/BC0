<?php

namespace Snail\Http\Controllers;

use Illuminate\Http\Request;
use Snail\Models\Group;
use Snail\Http\Requests\GroupForm;
use Snail\Models\Job;

class GroupsController extends Controller
{
    public function index($pid){
        return Group:: where('project_id', $pid)->with('job')->get();
    }
    public function show($gid) {
        return Group::find($gid);
    }
    public function store(GroupForm $form){
        return $form->persist();
    }
    public function delete(Request $request){
        Job::where('jobable_id', $request['id'])->where('jobable_type', 'group')->delete();
        Group::find($request['id'])->delete(); 
    }
}

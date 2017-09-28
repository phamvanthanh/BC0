<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Section;
use system\Models\Package;
use system\Http\Requests\SectionForm;
use system\Models\Job;
use system\Http\Controllers\PackagesController;

class SectionsController extends Controller
{
    public function index($pid){

        return Section::where('project_id', $pid)
                      ->with('job')
                      ->with('packages')
                      ->get();
    }
    public function show($gid) {

        return Section::with('job')->find($gid);
    }
    public function store(SectionForm $form){

        return $form->persist();
    }
    public function delete(Request $request) {
        return $this->destroy($request['id']);

    }
    public function destroy($id){
        
        if(Job::where('jobable_id', $id)->where('jobable_type', 'section')->delete()) {
            $p = new PackagesController;
            $packages = $p->index($id);
            foreach($packages as $package) {
                $p->destroy($package['id']); // Destroy package and job
            }

            Section::find($id)->delete(); 

            return response(['Section delete succeed'], 200);
        }
        
    }
}

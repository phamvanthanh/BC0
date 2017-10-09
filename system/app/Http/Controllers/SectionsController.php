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
    public function destroy($section_id){
        
        //Sequences
        //1. Delete jobs
        //2. Delete packages
        //3. Delete the section
        //4. Repeat steps 1->3 for Mirrored sections

        Job::where('jobable_id', $section_id)
            ->where('jobable_type', 'section')
            ->delete();
        
        $p = new PackagesController;

        $packages = $p->index($section_id);

        foreach($packages as $package)          
            $p->destroy($package->id); // Destroy package and job         
        
        Section::find($section_id)->delete(); 
            
        $msections = Section::where('mirror_id', $section_id)
                ->get();
        foreach ($msections as $ms)                     
            $this->destroy($ms->id);         

            return response(['Section delete succeed'], 200);
        
        
    }
}

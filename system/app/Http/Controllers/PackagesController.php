<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Section;
use system\Models\Package;
use system\Http\Requests\PackageForm;
use system\Models\Job;
use DB;
use system\Http\Controllers\QuantityController;

class PackagesController extends Controller
{

    protected function leaves($jid) {
       
        $pk = new QuantityController;
        return $pk->pullJobItems($jid); 
    }

    public function index($gid) {

       return Package::where('section_id', $gid)                                                             
                         ->with('job')->get();  
       
        
    }

    public function showByProjectId($pid) {

        $groups   = Section::where('project_id', $pid)->select('id')->get();

        $groupArr = collect($groups)->map(function ($ob) {
                            return ($ob->id);
                    });
        return Package::whereIn('section_id', $groupArr)->with('section')->get();
    }

    public function show($pkid) {
        return Package::find($pkid);
    }

    public function store(PackageForm $form) {
       return $form->persist();                
    }
    public function delete(Request $request) {
        return $this->destroy($request['id']);
    }
    public function destroy($id){
        if(Job::where('jobable_id', $id)->where('jobable_type', 'package')->delete())
           Package::find($id)->delete(); 
    }
   
}
   
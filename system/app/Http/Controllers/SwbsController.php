<?php

namespace system\Http\Controllers;
use DB;

use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use system\Models\Swbs;
use system\Models\Section;
use system\Http\Controllers\Uti;
class SwbsController extends Controller
{
    
    public function index($gid) {
        
        $uti = new Uti;
    

        $data = json_decode($uti->swbs($gid), true);
   
        if(count($data) > 0) {
                $swbs = $uti->buildTree($data, null);              
                return json_encode($swbs[0]);
        }
        return;
       
    }
    public function swbsCodesByProjectId($pid) {
        $groups = DB::table('sections')->where('project_id', $pid)->select('id')->get()->toArray();
        $groups = collect($groups)->map(function ($ob) {
                            return ($ob->id);
                        });
        $codes = DB::table('swbs')->whereIn('section_id', $groups)->select(DB::raw('DISTINCT code'))->get();    
        return collect($codes)->map(function ($ob) {
                            return ($ob->code);
                        });

    }
    public function swbsCodesByGroupId($pid = null ,$gid) { 

        $codes = DB::table('swbs')->where('section_id', $gid)->select('code')->get();    
        return collect($codes)->map(function ($ob) {
                            return ($ob->code);
                    });
    }
    public function pass($gid) {       
        $request = request(['codes']);
        $codeArray = $request['codes'];     
        $dataSet =[];
        $project = Section::find($gid);
        $pid = $project['project_id'];
        foreach($codeArray as $code){
            $dataSet[] = [
                'code'       => $code,
                'section_id'   => $gid,
                'project_id' => $pid 
            ];
        }       
        DB::table('swbs')->insert($dataSet); 
       
    }
    public function delete($gid) {
        $request = request(['codes']);
        $codeArray = array_values($request['codes']);          
        DB::table('swbs')->whereIn('code', $codeArray)
                         ->where('section_id',  $gid)
                         ->delete();
        
        
    }
    public function create($id) {
        $this->validate(request(), [
             'code'        =>'required | integer',
             'parent_code' =>'required | integer',
             'name'        =>'required',
             'quantify'    =>'required',
             'extension'   =>'required | integer'
       
          ]);
         $request = request(['code','parent_code', 'name', 'quantify', 'extension']);
         $request['project_id'] = (int)$id;       
         Pwbs::create($request);
    }
    public function leaves($gid) {
     
        $records  = $this->pull($gid);                             
        $parent_codes = $records->pluck('parent_code');
        $leaves       = $records->whereNotIn('code', $parent_codes); 
        $leaves       = json_decode($leaves, true);     
        return  array_values($leaves);           
     

    }


}

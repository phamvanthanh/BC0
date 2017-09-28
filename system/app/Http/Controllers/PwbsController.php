<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Pwbs;
use DB;
use PDO;
use Response;
use system\Http\Controllers\Uti;
use system\Http\Requests\PwbsForm;
use system\Http\Requests\PwbsUnit;

class PwbsController extends Controller
{
     
    public function index($id){
       
        $uti = new Uti;
    
        $data = json_decode($uti->pwbs($id), true);

       if(count($data) >0) {           
            $pwbs = $uti->buildTree($data, null);
            return json_encode($pwbs[0]);
       }
    }

    public function pass($pid) {
       
        $request = request(['codes']);
        $codeArray = $request['codes'];
     
        $dataSet =[];
        foreach($codeArray as $code){
            $dataSet[] = [
                'code'       => $code,
                'project_id' => $pid 
            ];
        }       
        DB::table('pwbs')->insert($dataSet); 
    }
    public function delete($pid) {
        $request = request(['codes']);
        $codeArray = array_values($request['codes']);  
             
        DB::table('pwbs')->whereIn('code', $codeArray)
                         ->where('project_id',  $pid)
                         ->delete();        
        
    }
    public function create(PwbsForm $form) {
        $form->persist();
    }
    public function leaves($pid) {      
        $uti = new Uti;
        $records = $uti->pwbs($pid);     
        $parent_codes =  $records->pluck('parent_code');      
        $leaves       = $records->whereNotIn('code', $parent_codes); 
        $leaves       = json_decode($leaves, true);       
        return  array_values($leaves);

    }
    public function unitify(PwbsUnit $form) {
        return $form->persist();    

    }
    public function commit(PwbsUnit $form) {
        return $form->commit();
    }
}

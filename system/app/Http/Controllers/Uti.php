<?php

namespace system\Http\Controllers;

// use Illuminate\Http\Request;
use DB;

class Uti 
{
      public function buildTree(array $elements, $parent_code = null) {
        $branch = array();
        $element['children'] = array();
        foreach ($elements as $element) 
        {				
            if ($element['parent_code'] === $parent_code)
            {
                $children = $this->buildTree($elements, $element['code']);

                if ($children) 
                    $element['children'] = $children;						
                else
                    $element['children'] = NULL;

                $branch[] = $element;
                    unset($element);
            }
        }
        return $branch;
    }
    public function wbs() {
        $wbs = DB::table('wbs')
                 ->select('id', 'code', 'parent_code', 'name')->orderBy('code', 'asc')->get();

       
        return $wbs;
    }
    //Pull raw data from pwbs table
    public function pwbs($id) {

        $pwbs_records = DB::table('pwbs')->leftJoin('wbs', 'pwbs.code', '=', 'wbs.code')          
            ->select(DB::raw('pwbs.project_id, pwbs.code, 
                        IFNULL(pwbs.parent_code, wbs.parent_code) as parent_code,  
                        IFNULL(pwbs.name, wbs.name) as name,
                        pwbs.quantify,
                        pwbs.unit,
                        pwbs.extension'
            ))
            ->where('project_id', '=', $id)
            ->orderBy('code', 'asc')
            ->get();   
  

       return $pwbs_records;
    }
    public function gwbs($gid) {
        //    $pid = Group::select('project_id')->find($gid);
           $pid = DB::table('sections')->where('id', $gid)->select('project_id')->first();
           
           $pid = $pid->project_id;  
     
           $gwbs = DB::table('gwbs')
                     ->join('pwbs', function($join) use ($pid) {
                         $join->on('gwbs.code', '=', 'pwbs.code')
                              ->where('pwbs.project_id', '=', $pid);
                     })
                     ->leftjoin('wbs', 'gwbs.code', '=', 'wbs.code')
                     ->select(DB::raw('IFNULL(pwbs.parent_code, wbs.parent_code) as parent_code,
                                       gwbs.code,
                                       IFNULL(pwbs.name, wbs.name) as name,
                                       pwbs.unit'))
                     ->where('gwbs.section_id', $gid)
                     ->get();
            // $length = count($gwbs);
         
            return $gwbs;

      
   }
}

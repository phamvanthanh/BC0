<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;

use DB;
use PDO;
use Response;
use system\Models\Project;
use system\Models\User;
use system\Models\Link;
use system\Models\Folder;

class ApiController extends Controller
{
    // Utility function to build tree from adjacy list 
    protected function buildTree(array $elements, $parent_code = null) {
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
    //Pull raw data from pwbs table
    protected function pullPwbs($id) {
       // DB::setFetchMode(PDO::FETCH_ASSOC);
        $pwbs_records = DB::table('pwbs')->leftJoin('wbs', 'pwbs.code', '=', 'wbs.code')          
            ->select(DB::raw('pwbs.project_id, pwbs.code, 
                        IFNULL(pwbs.parent_code, wbs.parent_code) as parent_code,  
                        IFNULL(pwbs.name, wbs.name) as name,
                        pwbs.quantify,
                        pwbs.extension'
            ))
            ->where('project_id', '=', $id)
            ->orderBy('code', 'asc')
            ->get();
       //DB::setFetchMode(PDO::FETCH_CLASS);
       
       return json_decode($pwbs_records, true);
    }
    public function pwbs($id){
       $data = $this->pullPwbs($id);
       if(count($data) >0)
       {
            $pwbs = $this->buildTree($data, null);
            return json_encode($pwbs[0]);
       }
    }
    public function wbs(){
        $wbs_records = DB::table('wbs')
                   ->select('code', 'parent_code', 'name')->get();
        if(count($wbs_records) >0)
        {
            $wbs_array =  json_decode($wbs_records, true);
            $wbs = $this->buildTree($wbs_array, null);
            return json_encode($wbs[0]);
        }
    }
   
    public function project($id){
        $project = Project::find($id);
        return $project;
    }
    public function clients(){
        $clients = User::all(); // This shall use find method when compile with rbac
        return $clients;
    }
    public function links($pid){
        $links = Link::where('project_id', $pid)->get();
        return $links;
    }
    public function folders($pid){
        $folders = Folder::where('project_id', $pid)->get();
        return $folders;
    }
}

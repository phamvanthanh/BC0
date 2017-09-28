<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Quantity;
use system\Models\Job;
use system\Models\Section;
use system\Models\Package;
use system\Http\Controllers\GwbsController;

use DB;

class ReportsController extends Controller
{
    protected function pullPackageQuantity($id) { 
       
           $job = Job::with('jobable')->find($id);  
           $quantum = $job->jobable['area'] * $job->jobable['complexity'];
       
           if($job['jobable_type'] == 'package') {
               
               $gid = $job['jobable']['group_id'];

               $pid = Section::select('project_id')->find($gid);
               $pid = $pid['project_id'];  
              
               $gwbs = DB::table('gwbs')
                     ->join('pwbs', function($join) use ($pid) {
                         $join->on('gwbs.code', '=', 'pwbs.code')
                              ->where('pwbs.project_id', '=', $pid);
                     })
                     ->leftjoin('wbs', 'gwbs.code', '=', 'wbs.code')
                     ->leftjoin('quantity', function($join) use($id) {
                         $join->on('quantity.code', '=', 'gwbs.code')
                              ->where('job_id', '=', $id);
                     })
                     ->leftjoin('quantity_files', 'quantity.id', '=', 'quantity_files.quantity_id')
                     ->leftjoin('quantity_markdowns', 'quantity.id', '=', 'quantity_markdowns.quantity_id')
                     ->leftjoin('audit', 'quantity.id', '=', 'audit.quantity_id')
                     ->leftjoin('audit_files', 'audit.id', '=', 'audit_files.audit_id')
                     ->leftjoin('audit_markdowns', 'audit.id', '=', 'audit_markdowns.audit_id')
                     ->select(DB::raw('IFNULL(pwbs.parent_code, wbs.parent_code) as parent_code,
                                       gwbs.code,
                                       IFNULL(pwbs.name, wbs.name) as name,
                                       pwbs.unit,
                                       quantity.id,
                                       quantity.job_id,
                                       quantity.quantity,
                                       IF(quantity.job_id IS NULL, null, '.$quantum.') as quantum,                                       
                                       quantity_files.name as file,
                                       quantity_files.path as file_path,
                                       quantity_markdowns.name as markdown,
                                       quantity_markdowns.path as markdown_path,
                                       IF(quantity.commit = 1, "true", "false") as commit,
                                       audit.id as audit_id,                                
                                       audit.quantity as a_quantity,
                                       ((audit.quantity - quantity.quantity)/quantity.quantity) as defer,
                                       IF(audit.commit = 1, "true", "false") as a_commit,
                                       audit_files.name as a_file,
                                       audit_files.path as a_file_path,
                                       audit_markdowns.name as a_markdown,
                                       audit_markdowns.path as a_markdown_path'))
                     
                     ->where('gwbs.group_id', $gid)
                     ->orderBy('code', 'asc')
                     ->get();
              return $gwbs;
           }       

    }

 
    protected function leaves($data) {
        $parent_codes = $data->pluck('parent_code');
        $leaves       = $data->whereNotIn('code', $parent_codes); 
        $leaves       = json_decode($leaves, true);     
        return  array_values($leaves);  
    }
    
    public function pullJobItems($jid) {

           $job = Job::with('jobable')->find($jid);           
           if($job['jobable_type'] == 'package') {

               return $this->pullPackageQuantity($jid);             
           } 

           if($job['jobable_type'] == 'section') {
               $gid = $job['jobable_id'];
               $pkids = Package::where('group_id', $gid)->with('job')->select('id')->get();
               $jids = $pkids->pluck('job.id');
               if(count($jids) > 0) {
                    $data = array();
                    
                    foreach($jids as $jid) {
                        $data[] = $this->pullJobItems($jid);
                    }
                    
                    $base = $data[0];
                    //Sum group quantity from package quantity
                    foreach($base as $index=>$item){
                        
                        for($i = 1; $i <count($data); $i++) {

                            $base[$index]['quantity'] += $data[$i][$index]['quantity'];
                            $base[$index]['a_quantity'] += $data[$i][$index]['a_quantity'];
                            $base[$index]['quantum'] += $data[$i][$index]['quantum'];
                            $base[$index]['cmtd_quantum'] += $data[$i][$index]['cmtd_quantum'];
                        }
                        unset($base[$index]['file']);
                        unset($base[$index]['file_path']);
                        unset($base[$index]['markdown']);
                        unset($base[$index]['markdown_path']);
                        unset($base[$index]['id']);
                        $base[$index]['job_id'] = $job['id'];
                    }
                    // Return group leaves with quantity sum derived from packages
                    return $base;
               }            

           }

           if($job['jobable_type'] == 'project') {
               $pid = $job['jobable_id'];
               $gids = Section::where('project_id', $pid)->with('job')->select('id')->get();
               $jids = $gids->pluck('job.id');
          
               $data = array();
               foreach($jids as $jid) {
                  $data[] = $this->pullJobItems($jid);
               }

               $collect = collect($data);
              
               return $collect->collapse();
           }
           

    } 
    
    public function index($jid) { 

        return $this->pullJobItems($jid); 
    }

    public function jwbs($jid) {

        $items = $this->pullJobItems($jid);          
        $uti = new Uti;
        $tree = $uti->buildTree($items, null);

        return $tree;
        
    }
        
}

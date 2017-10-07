<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use DB;
use system\Models\Job;
use system\Models\Section;
use system\Models\Audit;
use Maatwebsite\Excel\Facades\Excel;

class AuditsController extends Controller
{
     // Pull package data
    protected function pullPackageAudit($id) { 
       
           $job = Job::with('jobable')->find($id);  
           $quantum = $job->jobable['area'] * $job->jobable['complexity'];
       
           if($job['jobable_type'] == 'package') {
               
               $gid = $job['jobable']['section_id'];

               $pid = Section::select('project_id')->find($gid);
               $pid = $pid['project_id'];  
              
               $swbs = DB::table('swbs')
                     ->join('pwbs', function($join) use ($pid) {
                         $join->on('swbs.code', '=', 'pwbs.code')
                              ->where('pwbs.project_id', '=', $pid);
                     })
                     ->leftjoin('wbs', 'swbs.code', '=', 'wbs.code')
                     ->leftjoin('quantity', function($join) use($id) {
                         $join->on('quantity.code', '=', 'swbs.code')
                              ->where('job_id', '=', $id);
                     })
                     ->leftjoin('quantity_files', 'quantity.id', '=', 'quantity_files.quantity_id')
                     ->leftjoin('quantity_markdowns', 'quantity.id', '=', 'quantity_markdowns.quantity_id')
                     ->leftjoin('audit', 'quantity.id', '=', 'audit.quantity_id')
                     ->leftjoin('audit_files', 'audit.id', '=', 'audit_files.audit_id')
                     ->leftjoin('audit_markdowns', 'audit.id', '=', 'audit_markdowns.audit_id')
                     ->select(DB::raw('IFNULL(pwbs.parent_code, wbs.parent_code) as parent_code,
                                       swbs.code,
                                       IFNULL(pwbs.name, wbs.name) as name,
                                       pwbs.unit,
                                       quantity.id as quantity_id,
                                       quantity.job_id,
                                       quantity.quantity,
                                       IF(quantity.job_id IS NULL, null, '.$quantum.') as quantum,                                       
                                       quantity_files.name as file,
                                       quantity_files.path as file_path,
                                       quantity_markdowns.name as markdown,
                                       quantity_markdowns.path as markdown_path,
                                       quantity.commit,
                                       audit.id,                                
                                       audit.quantity as a_quantity,
                                       ((audit.quantity - quantity.quantity)/quantity.quantity) as defer,
                                       audit.commit as a_commit,
                                       audit_files.name as a_file,
                                       audit_files.path as a_file_path,
                                       audit_markdowns.name as a_markdown,
                                       audit_markdowns.path as a_markdown_path'))
                     
                     ->where('swbs.section_id', $gid)
                     ->orderBy('code', 'asc')
                     ->get();
              return $swbs;
           }       

    }
//IF(quantity.commit = 1, "true", "false") as commit,
    protected function pullJobItems($jid) {
        
           $job = Job::with('jobable')->find($jid);           
           if($job['jobable_type'] == 'package'){
               return $this->leaves($this->pullPackageAudit($jid));
             
           } 
           if($job['jobable_type'] == 'group'){
               $gid = $job['jobable_id'];
               $pkids = Package::where('section_id', $gid)->with('job')->select('id')->get();
               $jids = $pkids->pluck('job.id');
               if(count($jids) > 0) {
                    $data = array();
                    
                    foreach($jids as $jid) {
                        $data[] = $this->pullJobItems($jid);

                    }
                    
                    $base = $data[0];
                    //Sum group quantity from package quantity
                    foreach($base as $index=>$item){

                      ///  $base[$index]['sum_file'] = array();
                       // $base[$index]['sum_path'] = array();

                        for($i = 1; $i <count($data); $i++) {
                            $base[$index]['quantity'] += $data[$i][$index]['quantity'];
                            $base[$index]['a_quantity'] += $data[$i][$index]['a_quantity'];
                            //echo $data[$i][$index]['file'];

                            $base[$index]['sum_file'] += $data[$i][$index]['file'];
                            $base[$index]['sum_path'] += $data[$i][$index]['file_path'];

                            // array_push($base[$index]['sum_file'], $data[$i][$index]['file']);
                            // array_push($base[$index]['sum_path'], $data[$i][$index]['file_path']);
                        }
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
     
    public function index($id) {       
        /**
        * @var Job index
        *
        *  
        */
        $records = $this->pullPackageAudit($id);
      
        $parent_codes = $records->pluck('parent_code');
        $leaves       = $records->whereNotIn('code', $parent_codes); 
        $leaves       = json_decode($leaves, true);     
        return  array_values($leaves);      

    }

    public function store($jid, Request $request) {
        
        Audit::updateOrCreate(
         
            ['id' => $request['id']],   
     
            ['commit' => $request['commit'] ]          
           
        );
    }

    public function upload(Request $request) {
        $this->validate($request, [
            // 'id'          => 'required | integer', 
            'job_id'      => 'required | integer',
            'quantity_id' => 'required | integer',            
            'code'        => 'required',
            'file_type'   => 'required | string'
        ]);

        if($request['file_type'] == 'quantity'){
            $jobFile = new AuditFilesController;
            return $jobFile->upload($request);

        }
        if($request['file_type'] == 'markdown'){
            $markdown = new AuditMarkdownsController;
            return $markdown->upload($request);

        }     
  
    }
    
    
}

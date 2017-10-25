<?php

namespace system\Http\Controllers\Utilities;

use Illuminate\Http\Request;
use system\Http\Controllers\Controller;
use system\Models\Job;
use system\Models\Section;
use DB;


class QuantityUti extends Controller
{
    protected function pullPackageQuantity($id) { 
       
           $job = Job::with('jobable')->find($id);  
           $quantum = $job->jobable['area'] * $job->jobable['complexity'];
       
           if($job['jobable_type'] == 'package') {
               
               $gid = $job->jobable['section_id'];

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
                                       '.$gid.' as section_id,
                                       IFNULL(pwbs.name, wbs.name) as name,
                                       pwbs.unit,
                                       pwbs.difference,
                                       pwbs.commit as p_commit,
                                       quantity.id,
                                       '.$id.' as job_id,
                                       "'.$job['jobable']['name'].'" as job_name,
                                       "'.$job['jobable']['description'].'" as job_description,
                                       quantity.quantity,
                                       '.$quantum.' as quantum,                                       
                                       quantity_files.name as file,
                                       quantity_files.path as file_path,
                                       quantity_markdowns.name as markdown,
                                       quantity_markdowns.path as markdown_path,
                                       IF(quantity.commit = 1, true, false) as commit,
                                       quantity.updated_at as quantified_at,
                                       quantity.updated_at as committed_at,                                       
                                       (quantity.commit * '.$quantum.') as cmtd_quantum, 
                                       audit.id as audit_id,                                
                                       audit.quantity as a_quantity,       
                                       IF(audit.commit = 1, true, false) as a_commit,
                                       audit.updated_at as audited_at,
                                       audit.updated_at as a_committed_at, 
                                       (audit.commit * '.$quantum.') as cmtd_a_quantum, 
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

 
    protected function leaves($data) {
        $parent_codes = $data->pluck('parent_code');
        $leaves       = $data->whereNotIn('code', $parent_codes); 
        $leaves       = json_decode($leaves, true);     
        return  array_values($leaves);  
    }
    
    protected function pullJobItems($jid) {
           $job = Job::with('jobable')->find($jid);           
           if($job['jobable_type'] == 'package'){
               return $this->leaves($this->pullPackageQuantity($jid));
             
           } 
           if($job['jobable_type'] == 'section'){
               $pid = $job->jobable['project_id'];
               $gid = $job['jobable_id'];
               $pkids = Package::where('section_id', $gid)->with('job')->select('id')->get();
               
               // Get the job id of packages in array
               $jids = $pkids->pluck('job.id');
               
               $section_name = $job['jobable'][' indexname'];

               if(count($jids) > 0) {
                    $data = array();
                    
                    foreach($jids as $jid) {
                        //Pull items based on job id of packages in same group and save in $data array
                        $data[] = $this->pullJobItems($jid);
                    }
                    
                    // Get first package as base of the group
                    $base = $data[0];
                    
                    //Build an array of comits
                    

                    //Sum group quantity from package quantity
                   
                    // Loop over swbs items
                    foreach($base as $index=>$item){
                        $base[$index]['commit_array'] = array();   //Create a commit array for eacch item of the section
                        $base[$index]['project_id'] = $pid;     // Add project_id to each item of the section
                     
                        
                        //Create array of commit status with first element is the first found package of the section
                        array_push($base[$index]['commit_array'], [
                            'job_id'         => $data[0][$index]['job_id'],
                            'name'           => $data[0][$index]['job_name'],
                            'description'    => $data[0][$index]['job_description'],                            
                            'commit'         => $data[0][$index]['commit'],
                            'a_commit'       => $data[0][$index]['a_commit'],                           
                            'committed_at'   => $data[0][$index]['committed_at'],
                            'a_committed_at' => $data[0][$index]['a_committed_at'],                            
                            'quantum'        => $data[0][$index]['quantum']
                        ]);

                        
                        $base[$index]['commit'] = ($data[0][$index]['commit'] == 1? true: false);      //Assigne first package commit to base                  
                        
                        $base[$index]['a_commit'] = ($data[0][$index]['a_commit'] == 1? true: false); //Assigne first package a_commit to base 
                        
                        if($data[0][$index]['file_path'])
                            $base[$index]['combined_file'] = array($data[0][$index]['file_path']);  //Add file path to base file array
                   
                        if($data[0][$index]['a_file_path'])
                            $base[$index]['combined_a_file'] = array($data[0][$index]['a_file_path']); //Add a_file path to base a_file array
                        
                        if($data[0][$index]['markdown_path'])
                            $base[$index]['combined_markdowns'] = array($data[0][$index]['markdown_path']); //Add markdown path to base markdown array
                        
                        if($data[0][$index]['a_markdown_path'])
                            $base[$index]['combined_a_markdowns'] = array($data[0][$index]['a_markdown_path']); //Add a_markdown path to base a_markdwon array

                   
                        for($i = 1; $i <count($data); $i++) { // loop for every package of the section start from second package and sum to the base

                            array_push($base[$index]['commit_array'], [ // Add to base commit array
                                'job_id'         => $data[$i][$index]['job_id'],
                                'name'           => $data[$i][$index]['job_name'],
                                'description'    => $data[$i][$index]['job_description'], 
                                'commit'         => $data[$i][$index]['commit'],
                                'a_commit'       => $data[$i][$index]['a_commit'],                              
                                'committed_at'   => $data[$i][$index]['committed_at'],
                                'a_committed_at' => $data[$i][$index]['a_committed_at'],                              
                                'quantum'        => $data[$i][$index]['quantum']
                            ]);
                            if($data[$i][$index]['quantity'] != null && $data[$i][$index]['quantity'] != null)
                            $base[$index]['quantity'] += $data[$i][$index]['quantity']; //Sum quantity
                            if($data[$i][$index]['a_quantity'] != null && $data[$i][$index]['a_quantity'] != null)
                            $base[$index]['a_quantity'] += $data[$i][$index]['a_quantity']; //Sum a quantity

                            $base[$index]['cmtd_quantum'] += $data[$i][$index]['cmtd_quantum']; // Sum commit quantum

                            $base[$index]['cmtd_a_quantum'] += $data[$i][$index]['cmtd_a_quantum']; //Sum audit commit quantum

                            $base[$index]['quantum'] += $data[$i][$index]['quantum']; // Sum quantum
                            
                            $base[$index]['section'] = $section_name; //Add Section name index

                            $base[$index]['commit'] &= ( $data[$i][$index]['commit'] == 1? true : false); // Aggregate to section commit

                            $base[$index]['a_commit'] &= ($data[$i][$index]['a_commit'] == 1? true : false); // Aggregate to section a_commit
                          //  $base[$index]['sum_file'][] = $data[$i][$index]['file'];
                            if($data[$i][$index]['file_path'])
                                $base[$index]['combined_file'][] = $data[$i][$index]['file_path']; // Insert to  combined file array

                          //  $base[$index]['sum_a_file'][] = $data[$i][$index]['a_file'];
                            if($data[$i][$index]['a_file_path'])
                                $base[$index]['combined_a_file'][] = $data[$i][$index]['a_file_path']; // Insert to  combined file array

                            if($data[$i][$index]['markdown_path'])     
                                $base[$index]['combined_markdowns'][] = $data[$i][$index]['markdown_path']; // Insert to  combined file array
                            
                            if($data[$i][$index]['a_markdown_path'])
                                $base[$index]['combined_a_markdowns'][] = $data[$i][$index]['a_markdown_path']; // Insert to  combined file array
                        }

                        unset($base[$index]['file']);
                        unset($base[$index]['file_path']);
                        unset($base[$index]['a_file']);
                        unset($base[$index]['a_file_path']);
                        unset($base[$index]['markdown']);
                        unset($base[$index]['markdown_path']);
                        unset($base[$index]['a_markdown']);
                        unset($base[$index]['a_markdown_path']);
                        unset($base[$index]['id']);  
                        unset($base[$index]['a_committed_at']);
                        unset($base[$index]['committed_at']);    
                        unset($base[$index]['audited_at']);                     
                                         
                                             

                        $base[$index]['job_id'] = $job['id'];

                        if( $base[$index]['commit'] == true)
                            $base[$index]['commit'] = 1;
                        else
                            $base[$index]['commit'] = 0;

                        if( $base[$index]['a_commit'] == true)
                            $base[$index]['a_commit'] = 1;
                        else
                            $base[$index]['a_commit'] = 0;
                       
                       if($base[$index]['quantity'] > 0)
                            $base[$index]['defer'] = ($base[$index]['a_quantity']- $base[$index]['quantity'])/$base[$index]['quantity'];
                        else
                            $base[$index]['defer'] = 'N/A';

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
 
   


}

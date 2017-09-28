<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Auth;

use system\Models\Quantity;
use system\Models\Job;
use system\Models\Section;
use system\Models\Package;
use system\Http\Controllers\GwbsController;
use system\Http\Requests\QuantityForm;

use Maatwebsite\Excel\Facades\Excel;
// use LynX39\LaraPdfMerger\PdfManage;

use DB;
use ZipArchive;

class QuantityController extends Controller
{
    protected function pullPackageQuantity($id) { 
       
           $job = Job::with('jobable')->find($id);  
           $quantum = $job->jobable['area'] * $job->jobable['complexity'];
       
           if($job['jobable_type'] == 'package') {
               
               $gid = $job->jobable['section_id'];

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
                                       '.$gid.' as section_id,
                                       IFNULL(pwbs.name, wbs.name) as name,
                                       pwbs.unit,
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
                                       ((audit.quantity - quantity.quantity)/quantity.quantity) as defer,
                                     
                                       IF(audit.commit = 1, true, false) as a_commit,
                                       audit.updated_at as audited_at,
                                       audit.updated_at as a_committed_at, 
                                       (audit.commit * '.$quantum.') as cmtd_a_quantum, 
                                       audit_files.name as a_file,
                                       audit_files.path as a_file_path,
                                       audit_markdowns.name as a_markdown,
                                       audit_markdowns.path as a_markdown_path'))
                     
                     ->where('gwbs.section_id', $gid)
                     ->orderBy('code', 'asc')
                     ->get();
              return $gwbs;
                // IF(quantity.commit = 1, true, false) as commit,
            //      CAST(audit.commit as INTEGER) as a_commit,
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
                   
                    // Loop over gwbs items
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
                            'defer'          => $data[0][$index]['defer'],
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
                                'defer'          => $data[$i][$index]['defer'],
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
    public function store(QuantityForm $form) {

        $form->commit();
    }

    public function upload(Request $request) {
        
        if(Auth::user()->can('import-quantity')) {

            $this->validate($request, [
                'job_id'      => 'required | integer',  
                'code'        => 'required',
                'file_type'   => 'required | string'
            ]);

            if($request['file_type'] == 'quantity') {
                $jobFile = new QuantityFilesController;
               return $jobFile->upload($request);

            }

            if($request['file_type'] == 'markdown') {
                $markdown = new QuantityMarkdownsController;
                return $markdown->upload($request);

            }
        }
    }

    public function downloadQFile(Request $request) {
        
        $jid =  $request->id;
        $code = $request->c;
        // Get the job model to check jobable_type
        $job = Job::find($jid);       
        
        $items = $this->pullJobItems($jid);    
       
        $file_array = null;
        
        // return storage_path();      

        foreach($items as $item) {
            if($item['code'] == $code) {

                //If package, return file right away;
                if($job->jobable_type == 'package'){
                     if(file_exists($item['file_path']))
                        return response()->download($item['file_path']);
                     return response(['File does not exist.'], 404);
                }
            

                // If section or project return use the combined array;
                $file_array = $item['combined_file'];    
                break;            
            }
        }

        $down_name = $jid.'_'.$code.'_q';
                    
        $data = array(); 
            //loop over every file of the code
        if(!empty($file_array)) {
             foreach($file_array as $file) {
            
                $sheet_name = preg_replace('/\\.[^.\\s]{3,4}$/', '', basename($file)); 

                $coppied_sheet = Excel::selectSheets('Express')->load($file)->get(); 
                $data[] = ['name'=>$sheet_name, 'data'=>$coppied_sheet];
                
            }    // Our first sheet 

            Excel::create($down_name, function($combined_file) use($data) {
            
                foreach ($data as $file) {
            
                    $combined_file->sheet($file['name'], function($sheet) use($file) {
                        if(!empty($file['data']))
                            return $sheet->fromArray($file['data']);
                        return;
                    });
                }
                
            })->export('xlsx');

        }
        return ;

    }


    public function downloadAFile(Request $request) {
        
        $jid =  $request->id;
        $code = $request->c;
        
          // Get the job model to check jobable_type
        $job = Job::find($jid); 

        $items = $this->pullJobItems($jid);    
       //return $items;
        $file_array = null;
        
        foreach($items as $item) {
            if($item['code'] == $code) {
                if($job['jobable_type'] == 'package'){
                      if(file_exists($item['a_file_path']))
                        return response()->download($item['a_file_path']);

                      return response(['File does not exist.'], 404);
                }                  

                if($item['combined_a_file']) {
                    
                    $file_array = $item['combined_a_file'];    
                    break;
                }
                            
            }
        }

        $down_name = $jid.'_'.$code.'_a';
                    
        $data = array(); 
            //loop over every file of the code
        if(!empty($file_array)) {
             foreach($file_array as $file) {
            
                $sheet_name = preg_replace('/\\.[^.\\s]{3,4}$/', '', basename($file)); 

                $coppied_sheet = Excel::selectSheets('A')->load($file)->get(); 
                $data[] = ['name'=>$sheet_name, 'data'=>$coppied_sheet];
                
            }    // Our first sheet 

            Excel::create($down_name, function($combined_file) use($data) {
            
                foreach ($data as $file) {
            
                    $combined_file->sheet($file['name'], function($sheet) use($file) {
                        if(!empty($file['data']))
                            return $sheet->fromArray($file['data']);
                        return;
                    });
                }
                
            })->export('xlsx');

        }
        return ;
     }

     public function downloadMrkd(Request $request) {
          
          $jid =  $request->id;
          $code = $request->c;
          
          $job = Job::find($jid);

          $items = $this->pullJobItems($jid);  

          $file_array = null;
            
          foreach($items as $item) {
                if($item['code'] == $code) {
                    if($job['jobable_type'] == 'package') {
                        if(file_exists($item['markdown_path']))
                            return response()->download($item['markdown_path']);
                        else
                            return response(['File does not exist.'], 404);

                    }
                   
                  
                    if($item['combined_markdowns']) {
                        
                        $file_array = $item['combined_markdowns'];    
                        break;
                    }
                                
                }
          }
          
          $down_name = $jid.'_'.$code.'_mrkd';

        // //   $pdf = new PdfManage;

          if(!empty($file_array)) {
        //     //  foreach($file_array as $file) {
                 
        //     //      $pdf->addPDF($file, 'all');

        //     //  }
        //     //  $pdf->merge('download', $down_name);

        //     // $files = array('readme.txt', 'test.html', 'image.gif');
        //     // $file_array
            $zipname = $down_name.'.zip';
            $zip = new ZipArchive;
            if($zip->open($zipname, ZipArchive::CREATE) === TRUE) {
                   foreach ($file_array as $file) {
                        $zip->addFile($file, basename($file));
                   }
                   $zip->close();

            }         

            header('Content-Type: application/zip');
            header('Content-disposition: attachment; filename='.$zipname);
            header('Content-Length: ' . filesize($zipname));
            readfile($zipname);

            // response()->download($zipname); 
            unlink($zipname);
            return;

          }
          
     }

     public function downloadAMrkd(Request $request) {
          
          $jid =  $request->id;
          $code = $request->c;
         
          $job = Job::find($jid);

          $items = $this->pullJobItems($jid);  

          $file_array = null;
            
          foreach($items as $item) {
                if($item['code'] == $code) {
                    if($job['jobable_type'] == 'package') {
                        if(file_exists($item['a_markdown_path']))
                            return response()->download($item['a_markdown_path']);
                        return response(['File does not exist'], 404);
                        
                    }
                     

                    if($item['combined_a_markdowns']) {
                        
                        $file_array = $item['combined_a_markdowns'];    
                        break;
                    }
                                
                }
          }
          
          $down_name = $jid.'_'.$code.'_amrkd';

        //   $pdf = new PdfManage;

          if(!empty($file_array)) {
        //      foreach($file_array as $file) {
                 
        //          $pdf->addPDF($file, 'all');

        //      }
        //      $pdf->merge('download', $down_name);
        //   }

         $zipname = $down_name.'.zip';
            $zip = new ZipArchive;
            if($zip->open($zipname, ZipArchive::CREATE) === TRUE) {
                   foreach ($file_array as $file) {
                        $zip->addFile($file, basename($file));
                   }
                   $zip->close();

            }         

            header('Content-Type: application/zip');
            header('Content-disposition: attachment; filename='.$zipname);
            header('Content-Length: ' . filesize($zipname));
            readfile($zipname);

            // response()->download($zipname); 
            unlink($zipname);
            return;

          }
          
     }
}

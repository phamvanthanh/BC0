<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\AuditFile;
use system\Models\Audit;
use Maatwebsite\Excel\Facades\Excel;

class AuditFilesController extends Controller
{
    public function upload($request) {             
        
        $file = $request->file('file');
        $extension = $file->extension();    
      
        $audit_records = Excel::load($file)->first()->first(); 

        if($request['code'] == $audit_records['code']) {
            
            //If match update to table quantity or create new quantity record
            $audit = Audit::updateOrCreate(
                ['quantity_id' => $request['quantity_id']],
                [                   
                    'code'        => $request['code'],
                    'quantity'    => $audit_records['quantity']
                ]
            );

            //Move file to place
            $path = storage_path('audits');
            $name = $audit['id'].'_'.$request['code'].'.'.$extension;
            
      
            // Get the quantity_id from return quantity model and update the quantity_files table
            if($audit && $file->move($path, $name)) {
                 AuditFile::updateOrCreate(
            
                    ['audit_id' => $audit['id']],
                
                    [   'name' => $name,
                        'path' => $path.'/'.$name        
                    ]            
                );
                return response(['File import succeed'], 200);

            }
           return response(['Somehing is wrong'], 500);
             
        }
        return response(['Code is not matched'], 422);
        
    }
}

<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\QuantityFile;
use system\Models\Quantity;
use Maatwebsite\Excel\Facades\Excel;

class QuantityFilesController extends Controller
{
    public function upload($request) {             
        
        $file = $request->file('file');
        $extension = $file->extension();  

         $quantity_records = Excel::load($file)->first()->first(); 
        //  $quantity_records = Excel::selectSheets('Sum')->load($file); //select(['code', 'name', 'unit', 'quantity'])->get();    
        //  return $quantity_records;    
           
        // //Get the quantity from the file 
        // dd($quantity_records);          

        //Check for code match
        if($request['code'] == $quantity_records['code'] ) {
            if($quantity_records['quantity'] === null || $quantity_records['quantity'] === 'null')
                return response(['Quantity is not available.'], 422);
            
            //If match update to table quantity or create new quantity record
            $quantity = Quantity::updateOrCreate(
                ['id'=>$request['id']],
                [
                    'job_id'=>$request['job_id'],
                    'code'=>$request['code'],
                    'quantity'=>$quantity_records['quantity']
                ]
            );

            //Move file to place
            $path = storage_path('quantities');
            $name = $quantity['id'].'_'.$request['code'].'.'.$extension;
           
      
            // Get the quantity_id from return quantity model and update the quantity_files table
            if($quantity && $file->move($path, $name)) {
                  QuantityFile::updateOrCreate(
            
                    ['quantity_id' => $quantity['id']],
                
                    [   'name' => $name,
                        'path' => $path.'/'.$name        
                    ]
                
                );

                return response(['File import succeed'], 200);      
            }
            return response(['Something is wrong.'], 500); 
           
        }
        return response(['Code is not matched'], 422);
            
     

    }
  
}



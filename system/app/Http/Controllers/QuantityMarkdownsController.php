<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\QuantityMarkdown;

class QuantityMarkdownsController extends Controller
{
   public function upload($request) {  
            
        
        $file = $request->file('file');
        $extension = $file->extension();
        $name = $request['id'].'_'.$request['code'].'.'.$extension;      
   
        $path = storage_path('markdowns');
        if($file->move($path, $name)) {
            QuantityMarkdown::updateOrCreate(
         
                ['quantity_id' => $request['id']],
            
                [   'name' => $name,
                    'path' => $path.'/'.$name
                ]
            
            );
            return response(['Markdown upload succeed.'], 200);
        }
        
     

    }
}

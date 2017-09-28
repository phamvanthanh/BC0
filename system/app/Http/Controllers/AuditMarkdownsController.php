<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\AuditMarkdown;

class AuditMarkdownsController extends Controller
{
    public function upload($request) {             
        
        $file = $request->file('file');
        $extension = $file->extension();
        $name = $request['id'].'_'.$request['code'].'.'.$extension;     
   


        $path = storage_path('audits');
        $file->move($path, $name);
        if(AuditMarkdown::updateOrCreate(
         
            ['audit_id' => $request['id']],
          
            [   'name' => $name,
                'path' => $path.'/'.$name         
            ]
           
        ))
        return response(['Markdown upload succeed.'], 200);
     

    }
}

<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\File;
use system\Http\Requests\FileForm;

class FilesController extends Controller
{
    // public function index(){
    //     return File::all();
    // }
    public function showByFolder($fid) {
        return File::where('folder_id', $fid)->get();
    }
    public function upload($fid, Request $request) {
       
        $file = $request->file('file');
        $originalName = $file->getClientOriginalName();
        $name = $originalName;
        $path = 'project_files/folders/'.$fid;
        $file->move($path, $name);
        $exist = File::where('folder_id', $fid)
            ->where('name', $originalName)
            ->first();
        if(!$exist) {
            File::create(['folder_id'=>$fid, 'path'=>$path.'/'.$name, 'name'=>$name]);    
            return;
        }
        
        // abort(500, ['File exists.']);
       return response(['File already exists'], 500);
        
     
    }
    public function delete() {
        $request = request(['id']);
        $id = $request['id'];  
        $record = File::find($id); 
        $path = $record['path'];   
        
        if(file_exists($path)) {
            if(unlink($path)) {
                $record->delete();
                return response(['File delete success'], 200);
            }
                
        }
        else return response(['File not found.'], 404);
            
        
    }

    public function store(FileForm $form) {
        return $form->persist();
    }
    
}
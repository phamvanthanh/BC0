<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Folder;
use system\Http\Requests\FolderForm;


class FoldersController extends Controller
{
    public function index($pid) {
        return Folder::where('project_id', $pid)
                     ->orderBy('id')
                     ->get();        
    }

    public function store(FolderForm $form){
        return $form->persist();
    }
    
    public function delete(Request $request){

        $folder = Folder::find($request['id']);
        $folder_path = 'project_files/folders/'.$folder['id'];
        array_map('unlink', glob("$folder_path/*.*"));
        
        rmdir($folder_path);
        
        $folder->delete();

        return response(['Folder delete succeed'], 200); 
    }
}

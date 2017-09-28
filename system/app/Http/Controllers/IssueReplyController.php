<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Requests\IssueReplyForm;

class IssueReplyController extends Controller
{
    public function store(IssueReplyForm $form) {

        $form->persist();

    }

    public function upload(Request $request) {

        $file = $request->file('file');
        
        $originalName = $file->getClientOriginalName();
        $name = time().$originalName;
        $path = 'issues';// storage_path('issues');
        $file->move($path, $name);   
        $link = $path.'/'.$name;
        return response(["url"=>'/'.$link], 200);        
        
    }
}

<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Link;

class LinksController extends Controller
{
    public function index($pid){
        return Link::where('project_id', $pid)->get();
        
    }
    public function store($pid){
        $this->validate(request(), [
            'project_id' => 'required',
            'caption'    => 'required',
            'url'        => 'required'
        ]);

        $request = request(['id', 'project_id', 'caption', 'url']);
        if(!empty($request['id']))
        {
            Link::find($request['id'])->update($request);
            return;
        }
        Link::create($request);
    }
    public function delete($pid){
        $request = request(['id']);
        $lid = $request['id'];
        Link::find($lid)->delete(); 
    }

}

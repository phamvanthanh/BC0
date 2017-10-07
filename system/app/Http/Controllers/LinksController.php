<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Link;
use system\Http\Requests\LinkForm;

class LinksController extends Controller
{
    public function index($pid){
        return Link::where('project_id', $pid)->get();
        
    }
    public function store(LinkForm $form){
       return $form->persist();
    }
    public function delete($pid){
        $request = request(['id']);
        $lid = $request['id'];
        Link::find($lid)->delete(); 
        return response(['Link delete succeed.'], 200);
    }

}

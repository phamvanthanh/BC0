<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Nation;
use system\Http\Requests\NationForm;

class NationsController extends Controller
{
    public function index() {
        
        return Nation::all();
    }
    
    public function show($id) {
        
        return Nation::where('id', $id)->get();
    }

    public function store(NationForm $form) {
        
        return $form->persist();
        
    }

    public function delete(Request $request) {

        return Nation::findOrFail($request['id'])->delete();
    }
}

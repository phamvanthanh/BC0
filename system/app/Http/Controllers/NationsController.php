<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Nation;
use system\Http\Requests\NationForm;

class NationsController extends Controller
{
    public function index(Request $request) {


        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';
        
        if($limit) {
                 if(empty($query))
                        return Nation::orderBy($orderBy, $ascending)
                                        ->paginate($limit);
                    else 
                        return Nation::where('id', 'LIKE', "%{$query}%")
                                        ->orWhere('name', 'LIKE', "%{$query}%")
                                        ->orWhere('abbr', 'LIKE',"%{$query}%")                                       
                                        ->paginate($limit);
        }

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

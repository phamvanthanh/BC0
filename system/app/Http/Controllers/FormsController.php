<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Requests\FormForm;
use system\Models\Form;

class FormsController extends Controller
{
    public function index(Request $request) {
        
        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));
        $ascending = $ascending == 1? 'ASC' : 'DESC';

        return Form::where('id', 'LIKE',"%{$query}%")
                   ->orWhere('code', 'LIKE',"%{$query}%")
                   ->orWhere('name', 'LIKE',"%{$query}%")
                   ->orWhere('note', 'LIKE',"%{$query}%")                                       
                   ->orderBy($orderBy, $ascending)
                   ->paginate($limit);

    }

    public function show($id) {
        $form = Form::find($id);
        $headers = array(
              'Content-Type: application/xlsx',
            );
        return response()->download($form['path'], $form['code'].'.xlsx', $headers);
    }

    public function store(FormForm $form) {
        return $form->persist();
    }

    public function delete(Request $request) {
        $form = Form::find($request['id']);
        $form->delete();
        if(file_exists($form['path']))
            unlink($form['path']);
        return response(['File delete succeed'], 200);
    }
}

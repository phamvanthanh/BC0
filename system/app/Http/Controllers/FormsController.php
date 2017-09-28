<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Requests\FormForm;
use system\Models\Form;

class FormsController extends Controller
{
    public function index() {
        return Form::all();

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

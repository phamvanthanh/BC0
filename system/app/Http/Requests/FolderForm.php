<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Folder;

class FolderForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-delete-folder');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'project_id'=>'required | integer',
            'name'      =>'required'
        ];
    }
    public function persist() {
        Folder::updateOrCreate(
            ['id'=>$this->input('id')],
            $this->all());
        return response(['Folder post succeed'], 200);
    }
    // public function delete(){
        
    //     Folder::find($this->input('id'))->delete(); 
    //     return response('Folder delete succeed', 200);
    // }
}


       
   
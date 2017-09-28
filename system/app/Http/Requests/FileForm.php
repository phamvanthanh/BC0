<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\File;

class FileForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-file');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'id'   => 'required | integer',
            'name' => 'required'
        ];
    }

    public function persist() {

        $file = File::find($this->input('id'));
        
        $new_path = dirname($file['path']).'/'.$this->input('name');       
      
        if(rename($file['path'], $new_path)) {
             $file->update([
                'name'=>$this->input('name'),
                'path'=>$new_path
            ]);

            return response(['File post succeed'], 200);
        } 
        
        
       
    }
}

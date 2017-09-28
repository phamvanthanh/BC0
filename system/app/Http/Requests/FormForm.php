<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Form;

class FormForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('upload-delete-form');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'code' => 'required',
            'name' => 'required | string',          
            'file' => 'required | file'
            
        ];
    }

    public function persist() {

       symlink('/home/nhdyjjgwhosting/public_html/system/storage/forms', '/home/nhdyjjgwhosting/public_html/system/public/forms');
        

        if($this->input('id')){
            $form = Form::find($this->input('id'));
			if(file_exists($form['path']))
				unlink($form['path']);
        }

        $path = $this->upload();
    
        Form::updateOrCreate([
            'id' => $this->input('id')
        ],
        [
            'code' => $this->input('code'),
            'name' => $this->input('name'),
            'path' => $path
        ]);
        
        return response(['Upload form file succeed'], 200);
    }

    protected function upload() {
       
        $file = $this->file('file');
        $extension = $file->extension();     
        $path = 'forms';
        $name = 'F_'.$this->input('code');
        $name = $name.'.'.$extension;       
        $file->move($path, $name);      
        $path = $path.'/'.$name;

        return $path;
     
    }
}

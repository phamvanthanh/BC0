<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Permission;

class PermissionForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
      
        return $this->user()->can('create-update-permission');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        if($this->input('id'))
            return [
                'name'    => 'required|string',
                'display_name' => 'required|string',
                'description'  => 'required|string'
            ];
         return [
                'name'    => 'required|string|unique:permissions',
                'display_name' => 'required|string|unique:permissions',
                'description'  => 'required'
            ];
    }
    
    public function persist() {
         Permission::updateOrCreate(
             ['id'=>$this->input('id')],
             $this->only(['name', 'display_name', 'description'])
        );
        return response(['Permission post succeed.'], 200); 
    }
   
}

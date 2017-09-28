<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Role;
use Entrust;

class RoleForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-role');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name'         => 'required | string',
            'display_name' => 'required | string'
        ];
    }
    public function persist() {
        
                  
        Role::updateOrCreate(  
            ['id'=>$this->input('id')],
            $this->only(['name', 'display_name', 'description'])
        
        );  

        return response(['Role post succeed'], 200);

    }
}

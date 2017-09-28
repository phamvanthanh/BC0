<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\User;
class RoleUserForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
       
       return $this->user()->can('attach-detach-role');
    //    return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'user_id' => 'required | integer',
            'role_id' => 'required | integer'
        ];
    }
    public function persist() {       

        User::find($this->input('user_id'))->attachRole($this->input('role_id')); 

        return response(['Role attachment succeed'], 200);

    }
    public function detachRole() {
        User::find($this->input('user_id'))->detachRole($this->input('role_id'));
        return response(['Role detachment succeed'], 200);
    }
}

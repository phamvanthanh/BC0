<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Role;
Use Entrust;
class PermissionRoleForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        
         return $this->user()->can('attach-detach-role-permissions');

   
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'role_id',
            'permission_id'
        ];
    }

    public function persist() {
        
        Role::find($this->input('role_id'))->attachPermission($this->input('permission_id'));
        return response(['Permission attachment succeed'], 200);
    }

    public function detachPermission() {

        Role::find($this->input('role_id'))->detachPermission($this->input('permission_id'));
        return response(['Permission detachment succeed'], 200);
    }
}

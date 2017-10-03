<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\User;

class UserForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize() {
    
       return ($this->user()->can('create-update-user') || $this->user()->can('update-user'));    
       
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        
        $rules = [
             'first_name'=>'required | string',
             'last_name' =>'required | string',
             'email'     =>'required | email',
             'nation_abbr' =>'required |string',
             'status'    =>'required | integer'
                       
        ];
        if($this->input('id'))
            return $rules;
        $rules['email'] = 'required|email|unique:users';
        return $rules;
    }
    public function persist() {
        if($this->user()->can('create-update-user'))
            $inputs = $this->only([
                'first_name', 
                'last_name', 
                'email', 
                'phone',
                'organization',
                'nation_abbr', 
                'status',         
                'created_by']);
                
        if($this->user()->can('update-user'))
             $inputs = $this->only([
                'first_name', 
                'last_name',           
                'phone',
                'organization',
                'nation_abbr',              
                'created_by']);

        if($this->has('id')) {           
            User::where('id', $this->input('id'))->update($inputs);
            return response(['User post succeed'], 200);
        }
   
       
        $inputs['password'] = hash('md5', rand());
       
        User::create($inputs);   
        return response(['User post succeed'], 200);
       
    }
}

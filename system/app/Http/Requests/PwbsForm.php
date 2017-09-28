<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Pwbs;
class PwbsForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-pwbs');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        if($this->input('commit')) 
            return [
                 'project_id'  =>'required | integer',
                 'code'        =>'required', 
            ];

        return [
             'project_id'  =>'required | integer',
             'code'        =>'required',
             'parent_code' =>'required',
             'name'        =>'required | string',            
             'extension'   =>'required | integer'
        ];
    }
    public function persist() {       
         Pwbs::create($this->all());
         return response(['Post pwbs succeed'], 200);
    }
    public function commit() {
         Pwbs::where('project_id', $this->input('project_id'))
             ->where('code', $this->input('code'))
             ->update($this->only('commit'));
         
         return response(['Project item commit succeed'], 200);
    }
}

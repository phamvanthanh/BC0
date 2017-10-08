<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Pwbs;
class PwbsUnit extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('update-pwbs-unit');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'code'        =>'required',
            'project_id'  =>'required | integer',
            'unit'        =>'required | string | max: 5'   
        ];
    }
    
    public function persist() {
         Pwbs::where('project_id', $this->input('project_id'))
              ->where('code', $this->input('code'))
              ->update($this->only(['unit', 'difference']));
        
        return response(['Unit post succeed'], 200);

    }
}


         
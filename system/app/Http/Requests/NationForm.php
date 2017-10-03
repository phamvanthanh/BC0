<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Nation;

class NationForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-nation');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $rules = [
            'name'       => 'required | string',
            'abbr' => 'required | string'
        ];
        if($this->input('id'))
            return $rules;
        $rules = [
            'name'       => 'required|string|unique:nations',
            'abbr' => 'required | string|unique:nations'
        ];
        return $rules;
    }
    
    public function persist() {

        Nation::updateOrCreate(
            ['id'=>$this->input('id')],
            $this->only(['name', 'abbr'])
        );
       return response(['Nation post succeed'], 200);
    } 
}

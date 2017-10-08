<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Link;

class LinkForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-link');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
           'project_id' => 'required',
           'caption'    => 'required',
           'url'        => 'required'
        ];
    }

    public function persist() {
      

        $link = Link::updateOrCreate(['id'=>$this->input('id')],
            $this->only(['project_id', 'caption', 'url'])
        );
        if($link)
            return response(['Link post succeed.'], 200);

    }
}

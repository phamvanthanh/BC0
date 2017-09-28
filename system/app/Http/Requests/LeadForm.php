<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Lead;

class LeadForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'first_name' => 'required',
            'last_name'  => 'required',
            'email'      => 'required',
            'phone'      => 'required',
            'company'    => 'required',
            'subscription' => 'required'
        ];
    }

    public function persist() {
      
        $lead = Lead::updateOrCreate(['email'=>$this->input('email')],
            $this->only(['first_name', 'last_name', 'phone', 'company', 'message', 'subscription'])
        );
         if($lead)
             return redirect('https://breakcost.com/thank-you.php');
    }
}

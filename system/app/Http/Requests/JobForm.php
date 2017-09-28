<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Job;

class JobForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('rate-job');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'job_id' => 'required | integer',
            'rate'   => 'required | integer'
        ];
    }
    public function rate() {
        $job = Job::with('awarded')
                  ->find($this->input('job_id'));
       
        if(!empty($job['awarded'])) {
              $job->update($this->only(['rate', 'comment']));
              return response(['Job rate succeed'], 200);
        }

        return response(['Job is not awarded'], 400);
         
    }
}

<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

use system\Models\Bid;
use system\Models\Job;


class BidForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
       return ($this->user()->can('bid-job') || $this->user()->can('award-withhold-job'));            
        
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'job_id'  => 'required | integer',
            'user_id' => 'required | integer'
        ];
    }

    public function persist() {
        
        $job = Job::with('awarded')->find($this->input('job_id'));

        if(empty($this->input('id'))) 
        {

       
                $check = false;
                switch($job['jobable_type']) {
                    case 'package':
                    $check =  $this->user()->hasRole('surveyor');
                    break;
                    case 'section':
                    $check = $this->user()->hasRole('qto_controller');
                    break;
                    case 'project':
                    $check = $this->user()->hasRole('project_manager');
                    default:
                        break;

                }
                
                $check =  $this->user()->can('bid-job') && $check;
                 if($check) {
                     Bid::create($this->only(['job_id', 'user_id']));
                     return response(['Bid succeed.'], 200);
                 }
                 
                return response(['Action is not authorized.'], 403);
                
            
           
        }
        //  award or withhold a bid
        if($this->user()->can('award-withhold-job')) {
             if(!empty($job->awarded) && $this->input('status') == 'awarded')                  
                 return response(['This job is already awarded.'], 403);
            
            // Role::where('name', )
            Bid::where('id', $this->input('id'))->update($this->only(['status']));
            if ($this->input('status') == 'awarded')
                Job::where('id', $this->input('job_id'))
                    ->update(['user_id' => $this->input('user_id')]);
            else 
                Job::where('id', $this->input('job_id')) 
                    ->update(['user_id' => NULL]);
            // JobHolder::createOrUpdate(['job_id'=>$this->input('job_id'),  'role_id'])
                return response(['Job status updated.'], 200);
        }
       
    }
}

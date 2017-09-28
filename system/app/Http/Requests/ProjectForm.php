<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Project;
use system\Models\Job;
use system\Models\JobHolder;
use system\Models\Role;

class ProjectForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-project');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name'          =>'required | string',
            'user_id'       =>'required | integer',
            'nation_id'     =>'required | integer',
            'industry_id'   =>'required | integer',
            'job.from_date' =>'required | date',
            'job.to_date'   =>'required | date'          
         
        ];
    }

     /**
     * Get the response for a forbidden operation.
     *
     * @return \Illuminate\Http\Response
     */

 
    public function persist() {         

        $inputs = $this->only(['name', 'user_id', 'nation_id', 'industry_id', 'description', 'requirement']);
        
        
                
        $project = Project::updateOrCreate(
            ['id'=>$this->input('id')],
            $inputs,
            ['created_by'=>$this->user()->id]
        );
       
           
        $job = Job::updateOrCreate(
            ['jobable_id'=>$project->id, 'jobable_type'=>'project'],
            [
                'from_date' => $this->input('job')['from_date'],
                'to_date'   => $this->input('job')['to_date'],
                'status'    => $this->input('job')['status']
            ]
        );    
        
        // $role = Role::where('name', 'client')->first();
        
        // JobHolder::updateOrCreate(['job_id'=>$job['id'], 'user_id'=>$this->input('user_id'), 'role_id' =>$role['id'], 'status'=>'owner']); 

        return response(['Project information post succeed'], 200); 
    }
}



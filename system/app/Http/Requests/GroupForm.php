<?php

namespace Snail\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Snail\Models\Group;
use Snail\Models\Job;
class GroupForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-group');
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
           'name'       => 'required',
           'from_date'  => 'required | date',
           'to_date'    => 'required | date',
           'status'     => 'required'
        ];
    }
    public function persist() {
         $group =  Group::updateOrCreate(
            ['id'=>$this->input('id')],
            $this->all());

         $job = Job::updateOrCreate(
             
            ['jobable_id'=>$group->id, 'jobable_type'=>'group'],
           
            [
                'from_date' => $this->input('from_date'),
                'to_date'   => $this->input('to_date'),
                'status'    => $this->input('status')
            ]
        );

        $role = Role::where('name', 'controller')->first();
        
        JobHolder::updateOrCreate(['job_id'=>$job['id'],  'role_id' =>$role['id']]); 

        return response(['Group post succeed'], 200); 
        
    }
}


<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Section;
use system\Models\Job;
class SectionForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-section');
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
        
         if($this->input('id')) {
            
            $section = Section::find($this->input('id'));
            $section->update([
                                  'name'        => $this->input('name'),
                                  'description' => $this->input('description')
                              ]); 
                                       
         }
         else {

              $exist = Section::where('project_id', $this->input('project_id'))
                                ->where('name', $this->input('name'))
                                ->first();
              if($exist)           
                  return response(['Section name already exists.'], 400);
              
              $section =  Section::create($this->all());
         }
         

        
         $job = Job::updateOrCreate(
                
            ['jobable_id'=>$section->id, 'jobable_type'=>'section'],
        
            [
                'from_date' => $this->input('from_date'),
                'to_date'   => $this->input('to_date'),
                'status'    => $this->input('status')
            ]
        );

        return response(['Section post succeed'], 200); 



         
           
        // $role = Role::where('name', 'controller')->first();
        
        // JobHolder::updateOrCreate(['job_id'=>$job['id'],  'role_id' =>$role['id']]); 

        
        
    }
}


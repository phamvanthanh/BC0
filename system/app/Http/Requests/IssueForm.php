<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Issue;

class IssueForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-issue');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
         
            'job_id'      => 'required | integer',
            'title'       => 'required | string',
            'description' => 'required | string |  min: 8',
            
        ];
    }

    public function persist() {
        
        if($this->input('id')) {
            $id = $this->input('id');
            $issue = Issue:: find($id);

            if($issue['user_id'] == $this->user()->id) {
                Issue::where('id', $id)
                     ->update($this->only(['title', 'description', 'status']));
               
                return response(['Issue post succeed'], 200);  
                   
            }
            
            return response(['Your action authorized'], 403);  
      

        }
        $issue =  Issue::create(
            [
                'user_id'=>$this->user()->id,
                'job_id'=>$this->input('job_id'),
                'title' =>$this->input('title'),
                'description' => $this->input('description'),
                'status'      => $this->input('status')
            ]   
        
        );   

        return $issue['id'];

        
    }
}

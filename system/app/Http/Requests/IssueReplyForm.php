<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\IssueReply;

class IssueReplyForm extends FormRequest
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

            'issue_id' => 'required | integer',
            'job_id'   => 'required | integer',
            'reply'    => 'required | string | min: 8'
        ];
    }

    public function persist() {
        
        if($this->input('id')) {
            $id = $this->input('id');

            $reply = IssueReply:: find($id);

            if($reply['user_id'] == $this->user()->id) {
                IssueReply::where('id', $id)
                     ->update($this->only(['reply']));
               
                return response(['Reply post succeed'], 200);  
                   
            }
            
            return response(['Your action authorized'], 403); 

        }

        IssueReply::create([
            'issue_id' => $this->input('issue_id'), 
            'user_id'  => $this->user()->id,
            'job_id'   => $this->input('job_id'),
            'reply'    => $this->input('reply')]
            
        );

        response(['Reply post succeed'], 200);
    }
}

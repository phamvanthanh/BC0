<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Message;
use system\Models\JobMessage;
use system\Models\Unread;
use system\Models\Job;

class MessageForm extends FormRequest
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
            'from_job_id'  => 'required: integer',
            'to'           => 'required',           
            'message'      => 'required'
        ];
    }

    public function persist() {
        
        $message =  Message::create(            
             [
                 'user_id' => $this->user()->id,
                 'message' => $this->input('message')
             ]
        );
 
        if(!$this->input('private')) {
                
             foreach($this->input('to') as $to) {
                JobMessage::create([
                    'message_id'  => $message['id'],
                    'from_job_id' => $this->input('from_job_id'),
                    'to_job_id'   => $to
                ]);
            }
        }
        else {       

            JobMessage::create([
                'message_id'  => $message['id'],
                'from_job_id' => $this->input('from_job_id'),
                'to_job_id'   => $this->input('to'),
                'private'     => 1
            ]);
        }

            
        $message['from_job_id'] = $this->input('from_job_id');
     
        return $message;        

    }
}

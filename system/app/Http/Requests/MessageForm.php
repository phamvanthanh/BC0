<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Message;
use DB;


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
            'recipient_id' => 'required',
            'message'      => 'required'
        ];
    }

    public function persist() {
        
        $message =  Message::create(            
             [
                 'sender_id' => $this->user()->id,
                 'message'      => $this->input('message')
             ]
        );
        
        DB::table('message_recipient')
          ->insert([
              'recipient_id' => $this->input('recipient_id'),
              'message_id'   => $message->id
          ]);      
       
     
        return $message;        

    }
}

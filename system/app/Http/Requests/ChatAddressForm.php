<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\ChatAddress;

class ChatAddressForm extends FormRequest
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
            'sender_id',
            'recipient_id',
            'name'
        ];
    }

    public function persist() {
        
        ChatAddress::updateOrCreate(
            [
                'sender_id'=>$this->input('sender_id'), 
                'recipient_id'=>$this->input('recipient_id')
            ],
            $this->only(['sender_id', 'recipient_id', 'name'])

        );
    }
}

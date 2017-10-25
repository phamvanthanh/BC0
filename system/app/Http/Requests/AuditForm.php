<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Audit;
use DB;

class AuditForm extends FormRequest
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
            //
        ];
    }

    public function persist() {
        $this->commit();
    }

    protected function commit() {
        $item = Audit::where('id', $this->input(['id']))
                    ->update([
                        'commit' => $this->input['commit']
                        ]           
        );

        
    }
}

<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Quantity;
use system\Models\Audit;
use DB;
class QuantityForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('import-quantity');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'job_id' => 'required | integer',
            'code'   => 'required',
        ];
    }
    public function commit() {

        $commit = $this->input('commit') == 'true'? true: false; 
        $quantity = Quantity::updateOrCreate(
            ['job_id' => $this->input('job_id'), 'code' => $this->input('code')],
            ['commit'=>$commit]                   

        );
        if($quantity && $commit == false) {
            Audit::where('quantity_id', $quantity['id'])
                 ->update(['commit'=>false]);
        }

    }
}


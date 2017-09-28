<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Wbs;
use system\Models\Pwbs;

class WbsForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-delete-wbs');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'code'        => 'required',
            'name'        => 'required | string',
            'parent_code' => 'required'
        ];
    }
    
    public function persist() {
       
        if($this->input('id')) {

            $node = Wbs::find($this->input('id'));
      
            if($node['code'] !== $this->input('code')) {
                $new = Wbs::create($this->only(['code', 'parent_code', 'name', 'description']));
                if($new) {
                    Wbs::where('parent_code', $node['code'])
                        ->update([
                            'parent_code' => $this->input('code')
                        ]);
                    if($node->delete())
                        return response(['Wbs post succeed.'], 200);
                    
                    return response(['Could not delete record.'], 422);
                }
                return response(['Could not create new record.'], 422);
                
            }
            else if($node['code'] === $this->input('code') ){
                 $node->update($this->only(['name', 'description']));
                 return response(['Wbs update succeed.'], 200);
            }
               

        }
        else {
             Wbs::create(            
                $this->only(['code', 'parent_code', 'name', 'description'])
            );

            return response(['Wbs create succeed.'], 200);
        }    
           

    //    
    }

    public function delete() {
             $request = $this->all(); 
             
             $pwbs_exist = Pwbs::where(function ($query) use($request) {
                $query->where('code', '=', $request['code'])
                    ->orWhere('parent_code', '=', $request['code']);
            })->first();

          
        
            if(!$pwbs_exist) {
            
                Wbs::where('code', $request['code'])          
                ->delete();
                return response(['Delete wbs item succeed'], 200);
            }

            return response(['This item is in used in projects.'], 400);

            


    }
}

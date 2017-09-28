<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Package;
use system\Models\Job;
use system\Models\Role;
use system\Models\JobHolder;

class PackageForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-package');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'section_id'  => 'required | integer',
            'name'        => 'required',
            'area'        => 'required | integer',
            'complexity'  => 'required',        
            'from_date'   => 'required | date |date_format:Y-m-d',
            'to_date'     => 'required | date |date_format:Y-m-d',
            'status'      => 'required'
        ];
    }
    public function persist() {

      
        if($this->input('id')) {
            $package = Package::find($this->input('id'));
            $package->update(
                [
                    'name'        => $this->input('name'),
                    'description' => $this->input('description'),
                    'area'        => $this->input('area'),
                    'complexity'  => $this->input('complexity')
                ]);

        }
        else {
            $exist = Package::where('section_id', $this->input('section_id'))
                            ->where('name', $this->input('name'))
                            ->first();
        
            if($exist)
                return response(['Package name already exists'], 200);            

            $package =  Package::create(
                $this->only(['section_id', 'name', 'area', 'complexity', 'description']));          

        }
     

        $job = Job::updateOrCreate(
            ['jobable_id'=>$package->id, 'jobable_type'=>'package'],
           
            [
                'from_date' => $this->input('from_date'),
                'to_date'   => $this->input('to_date'),
                'status'    => $this->input('status')
            ]
        ); 
      

        return response(['Package post succeed'], 200);   
    }
}

       

       
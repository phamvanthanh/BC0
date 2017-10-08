<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Section;
use system\Models\Package;
use system\Http\Requests\PackageForm;
use system\Models\Job;
use system\Models\Swbs;
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
    protected function mirrorPackages($section) {
        
        $packages = Package::where('section_id',  $section->mirror_id)
                            ->get();
        foreach($packages as $package){
            $package['name'] .= '-MS';
            $package['section_id'] = $section->id;
            $package['mirror_id'] = $package->id;
            unset($package->id);
            $packageForm = new PackageForm;
            $packageForm->replace($package->toArray());
            $packageForm->persist();
        }
        
    }
    protected function mirrorSwbs($section) {
        $swbs = Swbs::where('section_id', $section->mirror_id)->get()->toArray();
        
        foreach ($swbs as $index=>$item) {
            $swbs[$index]['section_id'] = $section->id;
            unset($swbs[$index]['id']);
                      
        }
        Swbs::insert($swbs);
        
    }
    public function mirrorSection($section) {
        $this->mirrorSwbs($section);
        $this->mirrorPackages($section);

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
                  return response(['Section name is taken.'], 400);
              
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
        if(!empty($section->mirror_id) && !$this->input('id')) 
            $this->mirrorSection($section);

        return response(['Section post succeed'], 200); 
      
        
    }

}


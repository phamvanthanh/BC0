<?php

namespace system\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use system\Models\Project;
use system\Models\Section;
use system\Models\Job;
use system\Models\Pwbs;
use system\Http\Requests\SectionForm;
use system\Models\Folder;
use system\Models\File;
use system\Models\Link;
class ProjectForm extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return $this->user()->can('create-update-project');
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name'          =>'required | string',
            'user_id'       =>'required | integer',
            'nation_abbr'   =>'required | string',
            'industry_id'   =>'required | integer',
            'job.from_date' =>'required | date',
            'job.to_date'   =>'required | date'          
         
        ];
    }

     /**
     * Get the response for a forbidden operation.
     *
     * @return \Illuminate\Http\Response
     */
    protected function mirrorPwbs($project) {
        $pwbs = Pwbs::where('project_id', $project->mirror_id)->get()->toArray();
        
        foreach ($pwbs as $index=>$item) {
            $pwbs[$index]['project_id'] = $project->id;
            unset($pwbs[$index]['id']);
            unset($pwbs[$index]['unit']);
            unset($pwbs[$index]['commit']);            
        }
        Pwbs::insert($pwbs);
        
    }
    protected function mirrorSections($project) {
        $sections = Section::where('project_id',  $project->mirror_id)
                            ->get();
         foreach($sections as $section){
            $section['name'] .= '-MS';
            $section['project_id'] = $project->id;
            $section['mirror_id'] = $section->id;
            unset($section->id);
            $sectionForm = new SectionForm;
            $sectionForm->replace($section->toArray());
            $sectionForm->persist();
         }
    }
    protected function mirrorFolders($project) {
        $folders = Folder::where('project_id', $project->mirror_id)
                         ->get();
                       
        foreach($folders as $folder) {
            $folder->project_id = $project->id;
            $old_folder_id = $folder->id;
            unset($folder->id);
            $new_folder = Folder::create($folder->toArray());
            $this->mirrorFiles($old_folder_id, $new_folder->id);
        }       


    }
    protected function mirrorFiles($old_folder_id, $new_folder_id) {
        $files = File::where('folder_id', $old_folder_id)
                      ->get()
                      ->toArray();
        foreach($files as $index=>$file) {
            $files[$index]['folder_id'] = $new_folder_id;
            unset($files[$index]['id']);
        }
        File::insert($files);
    } 
    protected function mirrorLinks($project) {
        $links = Link::where('project_id', $project->mirror_id)
                     ->get()
                     ->toArray();
        foreach($links as $index=>$link) {
            $links[$index]['project_id'] = $project->id;
            unset($links[$index]['id']);
            
        }
        Link::insert($links);
    }

    protected function mirrorProject($project) {
        $this->mirrorPwbs($project);
        $this->mirrorSections($project);
        $this->mirrorFolders($project);
        $this->mirrorLinks($project);
         
                         
    }
 
    public function persist() {         

        $inputs = $this->only(['name', 'user_id', 'nation_abbr', 'industry_id', 'description', 'requirement', 'mirror_id']);
                                
        $project = Project::updateOrCreate(
            ['id'=>$this->input('id')],
            $inputs,
            ['created_by'=>$this->user()->id]
        );
       
           
        $job = Job::updateOrCreate(
            ['jobable_id'=>$project->id, 'jobable_type'=>'project'],
            [
                'from_date' => $this->input('job')['from_date'],
                'to_date'   => $this->input('job')['to_date'],
                'status'    => $this->input('job')['status']
            ]
        );   

        if($this->input('mirror_id')) {
            $index = Project::where('mirror_id', $this->input('mirror_id'))->count();
            $project->name .= '-MP'.$index;
            $project->save(); 
            $this->mirrorProject($project);
            return response(['Project copy succeed'], 200);    
        }
            
        
        return response(['Project post succeed'], 200); 
    }
}



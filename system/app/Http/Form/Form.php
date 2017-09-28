<?php
namespace system\Http\Form;
use Illuminate\Http\Requests;
use Illuminate\Foundation\Validation\ValidatesRequests;

abstract class Form {

    use ValidatesRequests;

    protected $request;
    protected $rules = [];

    public function __construct(Request $request = null) {
        $this->request = $request? : request();

    }

    public function save() {
        if($this->isValid()) {
             $this->persist();
             return true;
        }
        return false;
    }
    
    protected function isValid() {
        try {
            $this->validate($this->request, $this->rules);
        }
        catch(\Exception $e) {
            return $e->validator->errors();
           
        }
        
        return true;
    }

    public function __get($property) {
        // if($this->request->has($property)) {
            return $this->request->input($property);
        // }
    }



}
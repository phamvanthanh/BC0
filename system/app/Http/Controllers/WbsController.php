<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Controllers\Uti;
use system\Models\Wbs; 
use system\Models\Pwbs;
use system\Http\Requests\WbsForm;

class WbsController extends Controller
{
    public function index() {
         
        $uti = new Uti;
        $data = json_decode($uti->wbs(), true);
  
        if(count($data) >0) {           
            $wbs = $uti->buildTree($data, null);
            return json_encode($wbs[0]);
        }    
    }

    public function store(WbsForm $form) {
        return $form->persist();
    }
    
    public function delete(WbsForm $form) {
        return $form->delete();

        
        
      
    }
}

<?php

namespace system\Http\Controllers\Utilities;

use Illuminate\Http\Request;
use system\Http\Controllers\Controller;
use DB;

class IssueUti extends Controller
{
     public function countIssues() {  
        
        return DB::table('issues')                
                 ->count();
      
    }

    public function countOpenIssues() {       
        return DB::table('issues')
                 ->where('status', '<>', 'closed')   
                 ->count();

    }

    public function userJobIssues() {
        
    }


   
}

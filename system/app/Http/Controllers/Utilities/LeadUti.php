<?php

namespace system\Http\Controllers\Utilities;

use Illuminate\Http\Request;
use system\Http\Controllers\Controller;
use DB;

class LeadUti extends Controller
{
     public function countAllLeads() {  
        
        return DB::table('leads')                
                 ->where('sub', 1)
                 ->count();      
    }

    public function countNewLeads(Request $request) {       
        if(!$request['days'])
            $period = 7; // 7 days
        else
            $period = $request['days'];

        $date = new \DateTime;
        $date->modify('-'.$period.' days');
        $formatted_date = $date->format('Y-m-d H:i:s');

        return DB::table('jobs')
                 ->where('updated_at', '>=', $formatted_date)
                 ->count();

    }

    
}

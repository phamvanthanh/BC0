<?php

namespace system\Http\Controllers\Utilities;

use Illuminate\Http\Request;
use system\Http\Controllers\Controller;
use DB;

class ClientUti extends Controller
{
     public function countAllClients() {  
        
        return DB::table('users') 
                 ->join('role_user', 'role_user.user_id', '=', 'users.id') 
                 ->join('roles', 'roles.id', '=', 'role_user.role_id')              
                 ->where('name', 'client')
                 ->count();
      
    }

    public function countNewClients(Request $request) {       
        if(!$request['days'])
            $period = 7; // 7 days
        else
            $period = $request['days'];

        $date = new \DateTime;
        $date->modify('-'.$period.' days');
        $formatted_date = $date->format('Y-m-d H:i:s');

         return DB::table('users') 
                 ->join('role_user', 'role_user.user_id', '=', 'users.id') 
                 ->join('roles', 'roles.id', '=', 'role_user.role_id')              
                 ->where('name', 'client')
                 ->where('users.updated_at', '>=', $formatted_date)
                 ->count();

    }

    
}

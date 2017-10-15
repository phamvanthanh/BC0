<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use system\Models\User;
use system\Events\UserOnline;
use system\Http\Requests\UserForm; 
use system\Http\Requests\RoleUserForm; 
use DB;

class UsersController extends Controller
{
    public function index(Request $request) {

        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';
        $orderBy = $orderBy == 'full_name'? 'first_name': $orderBy;
       
    
        return User::where('id', 'LIKE', "%{$query}%")                                    
                        ->orWhere(DB::raw("CONCAT(`first_name`, ' ', `last_name`)"), 'LIKE', "%{$query}%")
                        ->orWhere('email', 'LIKE',"%{$query}%")
                        ->orWhere('phone', 'LIKE',"%{$query}%")
                        ->orWhere('organization', 'LIKE',"%{$query}%")                                       
                        ->orWhere('nation_abbr', 'LIKE',"%{$query}%")
                        ->orderBy($orderBy, $ascending)
                        ->paginate($limit);
        

   
        
    }
   
    public function show($id) { 
               
        return USER::with('roles')->find($id);        
    }  

    public function store(UserForm $form) {

        return $form->persist();          
    }

    public function assignRole(RoleUserForm $form) {

        return $form->persist();
    }

    public function detachRole(RoleUserForm $form) {
        
        return $form->detachRole();        
    }

    public function loggedInUser() {       
      
            $id = request()->user()->id;
            $user =  User::with('roles')->find($id);     
         
            return $user;         
               
        
    }
   

    

}

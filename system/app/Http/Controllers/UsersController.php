<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\User;
use system\Models\RoleUser;
use Illuminate\Support\Facades\Auth;
use system\Http\Requests\UserForm; 
use system\Http\Requests\RoleUserForm; 

class UsersController extends Controller
{
    public function index() {
        return User::with('nation')->get(); 
        
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
        if(Auth::check()) {
            $id = Auth::id();
            $user =  User::with('roles')->find($id);
         
            return $user;                
               
        }
    }
    // public function activateRole($role_id) {
    //     $id = Auth::id();
    
      
    //     RoleUser::where('user_id', $id)->update(['active'=>null]);
    //     RoleUser::where('user_id', $id)->where('role_id', $role_id)->update(['active'=>1]);
    // }


    

}

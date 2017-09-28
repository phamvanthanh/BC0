<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\User;
use system\Models\Role;
use system\Models\Permission;
use system\Http\Requests\UserForm; 

class AdminController extends Controller
{


    /*
    |--------------------------------------------------------------------------
    | Admin / User Section
    |--------------------------------------------------------------------------
    */    
    public function getUsers() {
        return User::with('nation')->with('roles')->with('activeRole')->get();      
        
    }
    public function showUser($id) {        
        return USER::with('roles')->find($id);        
    }
    public function storeUser(UserForm $form) {
       
       return $form->persist();        
    } 
}

<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Role;
use system\Http\Requests\RoleForm;
use system\Http\Requests\PermissionRoleForm;

class RolesController extends Controller
{
    public function index(Request $request) {
       
        return Role::all();
    }
    
    public function show($rid) {
        return  Role::with('perms')->find($rid);
    }

    public function store(RoleForm $form) {
        return $form->persist();
    }
    
    public function delete(Request $request) {
        
        return Role::findOrFail($request['id'])->delete();             
        
    }

    public function assignPermission(PermissionRoleForm $form) {
       return $form->persist();
       
    }
    
    public function detachPermission(PermissionRoleForm $form) {

        return $form->detachPermission();        
        
    }
}

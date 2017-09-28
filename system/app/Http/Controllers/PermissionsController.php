<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Permission;
class PermissionsController extends Controller
{
    public function index() {
        return Permission::all();
    }

    protected function update($id, $data) {
        Permission::where('id', $id)->update($data);
        return;
    }

    public function store(Request $request) {
        $this->validate($request, [
            'name' => 'required | string'
        ]);

        $id = $request['id'];
                
        if(empty($id)) 
           $role  = new Permission;
        else
          $role = Permission::findOrFail($id);     
        
        $role->name = $request['name'];
        $role->display_name = $request['display_name'];
        $role->description = $request['description'];
        $role->save();   
        return ;   
    }
    
    public function delete(Request $request) {
        
        $role = Permission::findOrFail($request['id']); 
        $role->delete();
      
        return;
    }
}

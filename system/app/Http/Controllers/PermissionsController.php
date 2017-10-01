<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Permission;
class PermissionsController extends Controller
{
    public function index(Request $request) {

     
        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';
        
        
        if(empty($query))
            return Permission::orderBy($orderBy, $ascending)
                             ->paginate($limit);
        else 
              return Permission::where('id', 'LIKE', "%{$query}%")
                               ->orWhere('name', 'LIKE', "%{$query}%")
                               ->orWhere('display_name', 'LIKE',"%{$query}%")
                               ->orWhere('description', 'LIKE', "%{$query}%")
                               ->paginate($limit);
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

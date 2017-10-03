<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Permission;
use system\Http\Requests\PermissionForm;
class PermissionsController extends Controller
{
    public function index(Request $request) {

     
        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';
        
        if($limit) {
             
            return Permission::where('id', 'LIKE', "%{$query}%")
                            ->orWhere('name', 'LIKE', "%{$query}%")
                            ->orWhere('display_name', 'LIKE',"%{$query}%")
                            ->orWhere('description', 'LIKE', "%{$query}%")
                            ->orderBy($orderBy, $ascending)
                            ->paginate($limit);
        }

        return Permission::all(); 
   
    }

    protected function update($id, $data) {
        Permission::where('id', $id)->update($data);
        return;
    }

    public function store(PermissionForm $form) {
       return $form->persist();
    }
    
    public function delete(Request $request) {
        
        $role = Permission::findOrFail($request['id']); 
        $role->delete();
      
        return response(['Delete permission succeed.'], 200);
    }
}

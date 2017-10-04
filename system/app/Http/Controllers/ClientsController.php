<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\User;
use DB;

class ClientsController extends Controller
{
    

    public function index(Request $request) {

        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        $ascending = $ascending == 1? 'ASC' : 'DESC';
        $orderBy = $orderBy == 'name'? 'first_name': $orderBy;
        if($limit)
        return User::whereHas('roles', function($query){
                        $query->where('name', 'client');
                    })
                    ->where(function($q) use($query){
                        return $q->orWhere(DB::raw("CONCAT(`first_name`, ' ', `last_name`)"), 'LIKE', "%{$query}%")
                                ->orWhere('email', 'LIKE',"%{$query}%")
                                ->orWhere('phone', 'LIKE',"%{$query}%")
                                ->orWhere('organization', 'LIKE',"%{$query}%")                                       
                                ->orWhere('nation_abbr', 'LIKE',"%{$query}%");
                    })                    
                    ->orderBy($orderBy, $ascending)     
                    ->paginate($limit);
        return User::whereHas('roles', function($query){
                        $query->where('name', 'client');
                    })
                    ->get();
                
    }
    public function show($uid) {
         return User::whereHas('roles', function($query){
            $query->where('name', 'client');
        })
        ->with('projects')
        ->find($uid);
    }
}

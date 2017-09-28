<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\User;

class ClientsController extends Controller
{
    

    public function index() {
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

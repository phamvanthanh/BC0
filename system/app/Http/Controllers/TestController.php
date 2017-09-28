<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class TestController extends Controller
{


    public function show() {
        // return Excel::load('/storage/quantities/4_31100.xlsx', function($reader) {
        //     $reader->get();
        // })->get();

        $load =  Excel::load('/storage/quantities/4_31100.xlsx')->first()->first();
       return $load;
        
    }
}

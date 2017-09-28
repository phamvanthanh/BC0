<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;

class ScheduleController extends Controller
{
    public function show($id)
    {
        return view('pages.projects.schedule');
    }
}

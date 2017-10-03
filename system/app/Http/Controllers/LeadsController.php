<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Requests\LeadForm;
use system\Models\Lead;
use DB;
class LeadsController extends Controller
{
    public function index(Request $request) {
        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));

        if($orderBy == 'name')
            $orderBy = 'first_name';
        $ascending = $ascending == 1? 'ASC' : 'DESC';
        
        return Lead::where('id', 'LIKE', "%{$query}%")                                    
                    ->orWhere(DB::raw("CONCAT(`first_name`, ' ', `last_name`)"), 'LIKE', "%{$query}%")
                    ->orWhere('email', 'LIKE',"%{$query}%")
                    ->orWhere('phone', 'LIKE',"%{$query}%")                    
                    ->orderBy($orderBy, $ascending)
                    ->paginate($limit);


    }
    public function store(LeadForm $form) {
        return $form->persist();
    }
}

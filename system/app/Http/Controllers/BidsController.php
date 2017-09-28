<?php

namespace system\Http\Controllers;
use system\Models\Bid;
use Illuminate\Http\Request;

use system\Http\Requests\BidForm;

class BidsController extends Controller
{
    public function index($jid)
    {
        return Bid::where('job_id', $jid)->with('user')->with('awards')->get();    
    }
    public function store(BidForm $form) {
       
      return  $form->persist(); 
    }
}

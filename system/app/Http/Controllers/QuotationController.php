<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;

class QuotationController extends Controller
{
    public function wizard()
    {
        return view('pages.market.quotations.quotation-wizard');        
    }
    public function index()
    {
        return view('pages.market.quotations.quotations');        
    }
    public function create()
    {
        return view('pages.market.quotations.create');        
    }
    public function edit()
    {
        return view('pages.market.quotations.edit');        
    }
}

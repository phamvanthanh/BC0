<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Requests\LeadForm;
use system\Models\Lead;
class LeadsController extends Controller
{
    public function index() {
        return Lead::all();
    }
    public function store(LeadForm $form) {
        return $form->persist();
    }
}

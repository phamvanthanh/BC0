<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Http\Requests\ChatAddressForm;
use system\Http\Controllers\JobsController;
use system\Models\ChatAddress;
use DB;
class ChatAddressController extends Controller
{
    public function index(Request $request) {
  

        $uid = $request->user()->id;

        return DB::table('chat_addresses')
                ->join('users', 'chat_addresses.recipient_id', '=', 'users.id')
                ->where('chat_addresses.sender_id', $uid)
                ->select(DB::raw('chat_addresses.sender_id,
                    chat_addresses.recipient_id,
                    users.first_name,
                    users.last_name,
                    users.status

                '))
                ->orderBy('users.first_name')
                ->get();
    }
    public function store(ChatAddressForm $form) {
        $form->persist();
    }
  
    public function invite($uid) {

    }

    public function addressAutomate() {
        return $this->normalAutoStore();
    }

    protected function normalAutoStore() {
       
        $j = new JobsController;
        $jobs = $j->jobs();    
        $uid = request()->user()->id;
        
        $form = new ChatAddressForm;
             
        foreach($jobs as $job) {
            foreach ($job->relateds as $r) {
           
                $u = DB::table('bids')
                  ->join('users', 'bids.user_id', '=', 'users.id')
                  ->where('bids.job_id', $r['id'])                 
                  ->where('bids.status', 'awarded')
                  ->select(DB::raw('
                        bids.user_id as recipient_id,
                        CONCAT(users.first_name," ", users.last_name) as name
                  '))
                  ->first();                
             
                if($u && $u->recipient_id != $uid){
                   
                    $form->replace([
                        'sender_id'    => $uid,
                        'recipient_id' => $u->recipient_id,
                        'name'         => $u->name
                    ]);
                    $form->persist();
                }
                    
               
            }

        }
    }
}

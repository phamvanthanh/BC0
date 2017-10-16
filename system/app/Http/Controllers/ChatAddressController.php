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

    public function addressAutomate(Request $request) {
        if($request->user()->hasRole('client')) {
            $uid = $request->user()->id;
            return $this->clientAddressBook($uid);
        }
            
        return $this->byJobAddressBook();
    }

    protected function byJobAddressBook() {
       
        $j = new JobsController;
        $jobs = $j->jobs();    
        $uid = request()->user()->id;
        
        $form = new ChatAddressForm;
             
        foreach($jobs as $job) {
            //By Job related address book
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
             
            if($job->info->jobable_type == 'project') {
                
               $c = DB::table('projects')
                  ->join('users', 'users.id', '=', 'projects.user_id')
                  ->where('projects.id', '=', $job->info->jobable_id)
                  ->select(DB::raw('
                        users.id as recipient_id,
                        CONCAT(users.first_name," ", users.last_name) as name
                  '))
                  ->first();
             
                if($c && $c->recipient_id != $uid){
                 
                    $form->replace([
                        'sender_id'    => $uid,
                        'recipient_id' => $c->recipient_id,
                        'name'         => $c->name
                    ]);
                    $form->persist();
                }
            }

        }
    }
    protected function clientAddressBook($uid) {
       
        $jids = DB::table('projects')
          ->join('jobs', function($q){
              $q->on('projects.id', '=', 'jobs.jobable_id')
                ->where('jobs.jobable_type', '=', 'project');
          })
          ->where('projects.user_id', '=', $uid)
          ->select(['jobs.id'])
          ->get();
      
        
        $form = new ChatAddressForm;
             
        foreach($jids as $jid) {
    
                $u = DB::table('bids')
                  ->join('users', 'bids.user_id', '=', 'users.id')
                  ->where('bids.job_id', $jid->id)                 
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

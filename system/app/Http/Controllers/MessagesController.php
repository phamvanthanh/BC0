<?php

namespace system\Http\Controllers;

use system\Events\MessagePosted as PostedMessage;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use system\Models\JobMessage;
use system\Models\Job;
use system\Models\Message;
use DB;
use system\Http\Requests\MessageForm;

class MessagesController extends Controller
{    
    
    public function index(Request $request) {     
        
        if($request['channel'] != 2) {
             if($request['private'] == "true")             
                return  $this->privateMessages($request['job_id'], $request['co_job_id'], $request['last_id']);
             return $this->teamMessages($request['job_id'], $request['last_id']);
        }
       
        return $this->channel2Messages($request['job_id'], $request['last_id']);
       
        
           
    }
    //Get message by job id;
    /**
    * @var job id,
    * @var message id 
    *
    */
    protected function privateMessages($id, $co_id, $last_id){
            // 
         
            if(!empty($last_id)) {
             
                $messages = JobMessage::with('fromjob')
                            ->with('tojob')
                            ->with('message')                           
                            ->where( function($query) use($id, $co_id) {
                                $query->where( function($q) use($id, $co_id) {
                                    $q->where('from_job_id', $id)
                                      ->where('to_job_id', $co_id);
                                })
                                ->orWhere(function($q) use($id, $co_id) {
                                    $q->where('from_job_id', $co_id)
                                      ->where('to_job_id', $id);
                                });
                            })    
                            ->where('private', 1)
                            ->where('id', '<', $last_id)                           
                            ->orderBy('created_at', 'desc')
                            ->limit(20)
                            ->get();          
              
            }
            else {            
               
                $messages = JobMessage::with('fromjob')
                            ->with('tojob')
                            ->with('message')                           
                            ->where( function($query) use($id, $co_id) {
                                $query->where( function($q) use($id, $co_id) {
                                    $q->where('from_job_id', $id)
                                      ->where('to_job_id', $co_id);
                                })
                                ->orWhere(function($q) use($id, $co_id) {
                                    $q->where('from_job_id', $co_id)
                                      ->where('to_job_id', $id);
                                });
                            })     
                            ->where('private',  1)                                        
                            ->orderBy('created_at', 'desc')
                            ->limit(20)
                            ->get(); 
            }
             
            $messages = collect($messages);
            
            return  $messages->sortBy('created_at')->values()->all();
        
    }
    //Get message by job id;
    /**
    * @var job id,
    * @var message id 
    *
    */
    protected function teamMessages($id, $last_id) {          

            if(!empty($last_id)) {
             
                $messages = JobMessage::with('fromjob')
                            ->with('tojob')
                            ->with('message')
                                                                  
                            ->where('private',  NULL) 
                            ->where( function($query) use($id) {
                                $query->where('from_job_id', $id)
                                        ->orWhere('to_job_id', $id);
                            })              
                            ->where('id', '<', $last_id)
                            ->orderBy('created_at', 'desc')  
                            ->groupBy('message_id')                           
                            ->limit(9)
                            ->get();  
            
               
            }
            else {
            
                $messages = JobMessage::with('fromjob')                            
                            ->with('tojob')
                            ->with('message')
                                            
                            ->where('private',  NULL) 
                            ->where( function($query) use($id) {
                                $query->where('from_job_id', $id)
                                        ->orWhere('to_job_id', $id);
                            })                          
                            ->groupBy('message_id') 
                            ->orderBy('created_at', 'desc')                          
                            ->limit(25)
                            ->get(); 
         
                
           }        
               
            $messages = collect($messages);
            
            return  $messages->sortBy('created_at')->values()->all();
    

    }

    protected function channel2Messages($id, $last_id){
       
         if(!empty($last_id)) {
             
                $messages = JobMessage::with('message')                           
                            ->where('from_job_id', $id)
                            ->where('to_job_id', $id)   
                            ->where('private', 1)
                            ->where('id', '<', $last_id)                           
                            ->orderBy('created_at', 'desc')
                            ->limit(9)
                            ->get();          
              
            }
            else {            
               
                $messages = JobMessage::with('message')                           
                            ->where('from_job_id', $id)
                            ->where('to_job_id', $id) 
                            ->where('private',  1)                                        
                            ->orderBy('created_at', 'desc')
                            ->limit(25)
                            ->get(); 
            }
             
            $messages = collect($messages);
            
            return  $messages->sortBy('created_at')->values()->all();

    }
    /**
    * @var $JobMessage collection
    *
    */
    protected function read(Request $request) {
           
        $unread_ids = $request['ids'];  
                  
        JobMessage::whereIn('id',  $unread_ids)
                  ->update(['read' => 1]);         
        
        
    }

    public function unreads($from, $to) {
       
        if($from =='any') {
             $unreads = JobMessage::where('read', null)
                             ->where('to_job_id', $to)
                             ->where('private', null)
                             ->count();
        }
        else if($from != $to) {
             $unreads = JobMessage::where('read', null)
                             ->where('private', 1)
                             ->where('from_job_id', $from)
                             ->where('to_job_id', $to)
                             ->count();
        }
        if($from == $to) {
            

            $unreads = JobMessage::with('message')
                            ->where('read', null)
                            ->where('private', 1)
                            ->where('from_job_id', $from)
                            ->where('to_job_id', $to)
                            ->get();  
            
            
            $uid = request()->user()->id;

            $filters = collect($unreads)->filter(function($value, $key) use($uid){
                return $value['message']['user_id'] != $uid;
            });
 
            return count($filters); 
        }
       
        return $unreads;
    }

    public function store(MessageForm $form) {

       $message = $form->persist();
     
       $job = Job::with('jobable')->find($message['from_job_id']);
       $jobable = $job->jobable;
 
       if(request('private'))
        $type = 'private';
       else
        $type = 'public';
       
       $channel = 'channel'.request('channel');

       event(new PostedMessage($message, $job, $jobable, $type, $channel));
       return ;
    
    }

    public function uploadFile(Request $request) {

        $this->validate($request, [
            'file' =>'required | image'
        ]);

        $file = $request->file('file');
        
        $originalName = $file->getClientOriginalName();
        $name = time().$originalName;
        $path = 'messages';// storage_path('issues');
        $file->move($path, $name);   
        $link = $path.'/'.$name;
        return response(["url"=>'/'.$link], 200);  

    }
}

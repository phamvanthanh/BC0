<?php

namespace system\Http\Controllers;

use system\Events\MessagePosted;
use Illuminate\Http\Request;
use system\Models\Message;
use system\Http\Requests\MessageForm;
use DB;


class MessageController extends Controller
{
    public function getPrivateMessages(Request $request) {
        
        $sender_id = $request->user()->id;
        $recipient_id = $request['recipient_id'];

        return DB::table('messages')
                 ->join('message_recipient',function($q) use($sender_id, $recipient_id){
                     $q->on( 'messages.id', '=', 'message_recipient.message_id')
                       ->where(function($q) use($sender_id, $recipient_id){
                            $q->where('message_recipient.recipient_id', '=', $recipient_id)
                            ->orWhere('message_recipient.recipient_id', '=', $sender_id);
                       });
                 })
              
                 ->join('users as sender', function($q) use($sender_id, $recipient_id) {
                     $q->on('messages.sender_id', '=', 'sender.id');
                 })
                 ->join('users as recipient', function($q) use($sender_id, $recipient_id) {
                     $q->on('message_recipient.recipient_id', '=', 'recipient.id');
                 })
                 ->where(function($q) use($sender_id, $recipient_id){
                     $q->where('messages.sender_id', $sender_id)
                       ->where('message_recipient.recipient_id', $recipient_id);
                 })
                 ->orWhere(function($q) use($sender_id, $recipient_id){
                     $q->where('messages.sender_id', $recipient_id)
                       ->where('message_recipient.recipient_id', $sender_id);
                 })
                 ->select(DB::raw('
                    messages.id,
                    messages.sender_id,
                    CONCAT(sender.first_name, " ", sender.last_name) as sender_name,
                    messages.message,
                    messages.created_at,
                    message_recipient.recipient_id,
                    message_recipient.is_read,
                    CONCAT(recipient.first_name, " ", recipient.last_name) as recipient_name                    
                    
                 '))
                 ->orderBy('messages.created_at', 'DESC')                 
                 ->paginate(20);

     
    }
    public function readMessages(Request $request) {

        $unread_ids = $request['ids']; 
        $recipient_id = $request['recipient_id'];  
                     
        DB::table('message_recipient')
          ->whereIn('message_id',  $unread_ids)
          ->where('recipient_id', $recipient_id)
          ->update(['is_read' => 1]);      

    }
    public function count(Request $request) {
        $sender_id = $request['sender_id'];
        $recipient_id =  $request['recipient_id'];
        return DB::table('messages')
                 ->join('message_recipient', 'messages.id', '=', 'message_recipient.message_id' )
                 ->where('message_recipient.recipient_id', $recipient_id )
                 ->where('messages.sender_id', $sender_id )
                 ->whereNull('is_read')
                 ->count();
    }
    public function store(MessageForm $form) {
        $message = $form->persist();       
        $channel = $form->user()->id."_".$form->input('recipient_id');
        event(new MessagePosted($message, $channel));
        return ;

    }

}

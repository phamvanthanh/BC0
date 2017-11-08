<?php

namespace system\Http\Controllers;

use Illuminate\Http\Request;
use system\Models\Message;
use system\Http\Requests\MessageForm;
use DB;


class NotificationController extends Controller
{
    public function index(Request $request) {
         
         $recipient_id = $request->user()->id;
         return DB::table('notification_recipient')
                  ->join('notifications', 'notifications.id', '=', 'notification_recipient.message_id')
                  ->where('notification_recipient.recipient_id', $recipient_id)
                  ->get();


    }
   
       

        
}

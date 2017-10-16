<?php

namespace system\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class MessagePosted implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;
    // use SerializesModels;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    /**
    * Message
    * @var Message 
    */
    public $message;

  

    public $channel;

    public function __construct($message,  $channel)
    {
        $this->message = $message;      
        $this->channel = $channel;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return Channel|array
     */
    public function broadcastOn()
    {
        return new Channel($this->channel);     
    }
}

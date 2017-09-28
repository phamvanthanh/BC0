<?php

namespace system\Events;

// use system\Models\Message;
// use system\Models\Job;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class MessagePosted implements ShouldBroadcast
{
    // use Dispatchable, InteractsWithSockets, SerializesModels;
    use SerializesModels;

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

    /**
    * Job
    * @var Job 
    */
    public $job;

    public $jobable;

    public $type;

    public $channel;

    public function __construct($message, $job, $jobable, $type, $channel)
    {
        $this->message = $message;
        $this->job = $job;
        $this->type = $type;
        $this->jobable = $jobable;
        $this->channel = $channel;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return Channel|array
     */
    public function broadcastOn()
    {
        return new Channel($this->channel.$this->type.$this->job->id);     
    }
}

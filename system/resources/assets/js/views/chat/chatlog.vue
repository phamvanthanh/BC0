<template>
<div class="msg-wrapper">
    <div   class="chatroom-heading pl-5 pt-5">							   
           <span class="display-block fs-16 fw-600">{{contact.first_name}} {{contact.last_name}}</span>                                 
    </div>

    <div id="chatroom-log" class="chatroom-log pt-10"  @scroll="scrollFunction"  >    
            <div  :id="message.id" v-for="message in messages"  class="display-block">
                <div  class="display-block text-center day-block" >
                    
                </div>
                <div class="media-head pl-10" v-if="message.displayUser"  >                    
                    <div class="display-block mb-5 msg-title">                     
                          <span class="display-block fs-11 fw-600">{{message.sender_name}}</span>
                    </div>                                   
                </div>          

                <div class="media-body pl-35"  >
                    <div  :class="[{first: message.isHeader}, 'msg-content display-block pr-10']">
                          <span v-html="message.message" class="message" ></span>                          
                          <span v-if="message.displayTime" class="time pull-right">{{message.time}} </span>
                          <span  :ref='"notice"+message.id' class="hidden" ><i class="icon-notification2"></i> Not Delivered</span>
                    </div>
                    
                </div>
            </div> 
            <div class="bottom-padding">
            </div>
    </div>
</div> 
</template>

<script>
// var Pusher = require('pusher');
export default {
    props: ['contact'],

    data() {
        return {
            scrollBottom: true,
            oldHeight: 0,
            messages: [],
            page: 1 
        }        
    },
    created() {
        
    },
    mounted() {
     
         this.getMessages();  
        if(this.contact) {
            this.startChannel();      
        }
   
        bus.$on('newmessage', (message)=>{
            this.notsent = false;
            let last = {
                sender_id: null,
            }
            if(this.messages.length > 0) 
                last = this.messages[this.messages.length-1];          

            message = this.formatNewMessage(message, last);
            this.messages.push(message);
        });
        bus.$on('messagenotsent', (e)=>{
            var notsent_el = 'notice'+e.id;         
            this.$refs[notsent_el][0].className = "time pull-right pr-20 text-danger";
            
        });
              
    },
    filters: {
        capital(val) {
            return capitalize(val);
        }
    },
  
    updated() {
          
          if(!this.scrollBottom){
               var el = this.$el.querySelector("#chatroom-log");
               var newHeight = el.scrollHeight;
               $(el).scrollTop(newHeight - this.oldHeight);   
                          
          }
          else {
              this.updateScroll();
          }    
    }, 

    watch: {
        'contact.recipient_id' : function(val, oldVal) {
            if(val != oldVal && oldVal != null){
                 this.getMessages();
                 this.startChannel();
                 this.loading = true;
            }
               
        }
    },
    destroyed() {
        bus.$off();
    },
    methods: {
        getMessages() {
         
            this.scrollBottom = true;

            axios.get('/api/messages', {params: {recipient_id: this.contact.recipient_id, page: 1}})
                .then(({data})=>{                   
                    this.messages = this.formatMessages(data.data.reverse());
                            
                })
                .catch((error) => {
                    console.log(error);
                });
            			
		},
        formatMessages(messages) {
            var length = messages.length, i = 0, unreads = [];

            for(i; i < length; i++) {
                
                if(messages[i].is_read != 1)
                    unreads.push(messages[i].id);

                if(i == 0) {
                
                    messages[i].time = moment(messages[i].created_at).format('lll'); 
                    messages[i].displayUser = true;
                    messages[i].displayTime = true;
                   
                    
                }
                
                else {      
                    
                    var lastday = moment(messages[i-1].created_at).format("L"); 
                    var nowday = moment(messages[i].created_at).format("L");
                                    
                    if(nowday != lastday){
                      
                        messages[i].displayTime = true;
                        messages[i].time = moment(messages[i].created_at).format('lll');                        
                    }                           
                    else {
                                                                   
                        messages[i].time = moment(messages[i].created_at).format('LT');
                        messages[i].displayTime = true; 
                    } 

                    if (messages[i].sender_id != messages[i-1].sender_id) 
                        messages[i].displayUser = true; 
                    else 
                        messages[i].displayUser = false;
                  
                }
    
            }

            if(unreads.length > 0) {             
                this.read(unreads, this.contact.sender_id); 
            }
            return messages;
        },
        formatNewMessage(message, last) {
          
            message.created_at = moment(message.created_at).format('LT');
            if(message.sender_id != last.sender_id)
                message.displayUser = true; 
            else
                message.displayUser = false; 

            message.displayTime = true;
               
            return message;
        },
        updateScroll(){        
            var  element = this.$el.querySelector("#chatroom-log");
            element.scrollTop = element.scrollHeight;          
                       
        },

   
    
        scrollFunction() {           
          
            if ($('#chatroom-log').scrollTop() < 1){
                
                this.scrollBottom = false; 
                               
                this.page++;
                this.oldHeight = this.$el.querySelector("#chatroom-log").scrollHeight;
                var params = {              
                                  
                    recipient_id: this.contact.recipient_id,
                    page: this.page
                };

                var last = this.messages[0];
               
				axios.get('/api/messages', {params})               
				 .then(({data})=>{
                     
                     if(data.data.length > 0) {
                            
                        var newMessages = data.data.reverse();;
                        newMessages.unshift(last);
                   
                        newMessages = this.formatMessages(newMessages);  
                        // console.log(newMessages)
                        newMessages.shift();
                        if(this.page >= data.last_page)
                            newMessages[0].displayUser = true;                     
                        this.messages.unshift(...newMessages); 
                   
                     }
               
				 });         
				
			}
		}, 
        read(ids, recipient_id) {
            var data = {
                ids: ids,
                recipient_id: recipient_id
            };
            axios.post('/api/messages/read', data)
                 .then(({data}) => {           
                     bus.$emit('readmessages', this.contact.recipient_id);
                 })
                 .catch((error)=>{console.log(error)})
        },
        startChannel() {       

            var pusher = new Pusher('806c86de02562f12daec', {
                cluster: 'ap1',
                encrypted: true
            });

            var i;            
                     
            var channel = pusher.subscribe(this.contact.recipient_id+'_'+this.contact.sender_id);            
            channel.bind('system\\Events\\MessagePosted',(data)=>{
                
                    let last = this.messages[this.messages.length-1];
                    data.message.sender_name = this.contact.first_name+' '+this.contact.last_name; 
                    let message = this.formatNewMessage(data.message, last);                
                    this.scrollBottom = true;                                      
                    this.messages.push(message);
            });          
   
        }

    }

}

</script>
<style lang="scss">
@import './../../../sass/components/_variables';

.message img {
    max-width: 300px;
    max-height: 150px;
}
#chat-messages {
    height: 110%;
}

.message .msg-content {
   position: relative;
 
   width: 100%;

   display: inline-block;
}


 .message .msg-content > i {
   top: 0;
   margin: 2px;
 }
 .message .reversed .msg-content {
   text-align: left;
   color: #fff;
 }

 .message .date-step.media {
   text-align: center;
   margin-left: 0;
   margin-right: 0;
   color: #999;
 }
 .message .chat-thumbs img {
   margin-top: 5px;
   margin-bottom: 5px;
   max-height: 100px;
   height: auto;
   max-width: 100%;
   display: inline-block;
   border-radius: 4px;
 }
 .message .first:before,
 .message .first:before {
   border-top: 0px solid transparent;
   border-right: 12px solid;
   border-right-color: inherit;
   border-bottom: 10px solid transparent;
 }


 .message .owner .media-annotiation{

  color: $chat-reverse-annotation-color;
}


 @media (min-width: 769px) {
   .message .media {
     margin-right: 10%;
   }
   .message .media.reversed {
     margin-right: 0;
     margin-left: 20%;
   }
 }
.media-head  span {
    line-height: 1 !important;
}

</style>

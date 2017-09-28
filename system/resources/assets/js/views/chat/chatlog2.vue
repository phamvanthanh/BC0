<template>
    <!-- CLIENT CHATLOG-->
<div class="msg-wrapper">
    <div :class="{loader:loading}"></div>  
    <div id="chatroom-log" class="chatroom-log pt-10" :class="{hidden:loading}"  @scroll="scrollFunction" v-if="job.job_id" >       
            <div  :id="'msg'+message.id" v-for="message in messages" :class="{owner: !message.isGuest}" class="message display-block">
                <div v-if="message.day" class="display-block text-center day-block" >
                    
                </div>
                <div class="media-head pl-10" v-if="message.isHeader"  >                    
                    <div class="display-block mb-5 msg-title">      
                          <span class="display-block fw-600">{{message.title}}</span>
                    </div>
                                   
                </div>          

                <div class="media-body pl-35"  >
                    <div  :class="[{first: message.isHeader}, 'msg-content display-block']">
                          <span  v-cloak  v-html="message.message.message"></span>
                          <span class="pull-right">{{message.time}} </span>
                    </div>
                    
                </div>
            </div>       
    </div>
</div> 
</template>

<script>
// var Pusher = require('pusher');
export default {
    props: ['job'],

    data() {
        return {
            scrollBottom: true,
            oldHeight: 0,
            messages: [],
            loading: false,
            show: false
        }        
    },
    created() {
      
        let _this = this;
        if(this.job)
            this.getMessages(this.job.job_id);

        bus.$on('getmessages', function() {
            _this.getMessages(_this.job.job_id);
        });
       
        var pusher = new Pusher('806c86de02562f12daec', {
            cluster: 'ap1',
            encrypted: true
        });
        
        // Pusher.logToConsole = true;
        var i;
        
        
        if(!this.job.private)
            for(i = 0; i < this.job.relateds.length; i++) {
                let id = this.job.relateds[i].job_id;
                    
                var channel = pusher.subscribe('channel'+this.$parent.channel+'public'+id); 
           
                
                channel.bind('system\\Events\\MessagePosted', function(data) {
                    
                        let last = _this.messages[_this.messages.length-1];
                        let message = _this.formatNewMessage(data, last, _this.job.job_id);
                    
                        this.scrollBottom = true;                                      
                        _this.messages.push(message);
                });          
            } 
        else {
               var channel = pusher.subscribe('channel'+this.$parent.channel+'private'+this.job.job_id);                 
             
                channel.bind('system\\Events\\MessagePosted', function(data) {
                    
                        let last = _this.messages[_this.messages.length-1];
                        let message = _this.formatNewMessage(data, last, _this.job.job_id);
                    
                        this.scrollBottom = true;                                      
                        _this.messages.push(message);
                });    

        }
               
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
        'job.job_id' : function(val) {
            if(val)
                this.getMessages(val);
        }
    },

    methods: {
        getMessages(id, last_id) {
            this.scrollBottom = true;
        
            if(id){
                var params = {                  
                    job_id: this.job.job_id,  
                    co_job_id: this.job.co_job_id,                
                    private: this.job.private,
                    last_id: last_id,
                    channel: 2
                };
                axios.get('/api/messages/jobs', {params})
				 .then(({data})=>{
                     this.loading = false;
                     if(data.length > 0) {
                          
                        this.messages = this.formatMessages(data, this.$store.state.user.id);
                                                 
                     }                       
                     else 
                        this.messages = [];                     
                     setTimeout( ()=>{
                        this.updateScroll();
                     }, 0);
                                
				 })
                 .catch((error) => {
                     console.log(error);
                 });
            }			
		},

        updateScroll(){        
            var  element = this.$el.querySelector("#chatroom-log");
            element.scrollTop = element.scrollHeight;          
                       
        },

        formatMessages(data, id) {                    
              
                var unreads = [];
                data[0].isHeader = true; 
                data[0].day = moment(data[0].created_at).format('lll');
                data[0].isDay = true;

                if(data[0].message.user_id == id) {
                    data[0].isGuest = false; 
                    data[0].title = 'You';
                }
                else {
                  data[0].isGuest = true; 
                  if(data[0].message.user_id == this.job.project.user_id)
                    data[0].title = 'Client';
                  else
                    data[0].title = 'Project Manager';
                }
      
                if(data[0].message.user_id != id && data[0].read != 1)                                  
                    unreads.push(data[0].id);

                for(var i=1; i < data.length; i++) {
                 
                    if(data[i].message.user_id != id && data[i].read != 1 ) 
                        unreads.push(data[i].id);

                    if(data[i].message.user_id != id )
                    data[i].isGuest = true;
                    if(data[i].message.user_id == data[i-1].message.user_id) {
                        data[i].isHeader = false;
                    }
                    
                    else {
                        data[i].isHeader = true;
                    }                   
                    
                    
                    var lastday = moment(data[i-1].created_at).format("MMM Do YY"); 
                    var nowday = moment(data[i].created_at).format("MMM Do YY");
                    
                    
                    if(nowday != lastday){
                        data[i].isDay = true;
                        data[i].day = moment(data[i].created_at).format('lll');                        
                    }                           
                    else {
                        var lasttime = moment(data[i-1].created_at).format('LT');
                        var nowtime = moment(data[i].created_at).format('LT');
                      
                            data[i].time = nowtime;                           

                    }

                    if(data[i].message.user_id == id) {
                        data[i].isGuest = false; 
                        data[i].title = 'You';
                    }
                    else {
                        data[i].isGuest = true; 
                        if(data[i].message.user_id == this.job.project.user_id)
                            data[i].title = 'Client';
                        else
                            data[i].title = 'Project Manager';
                    }
      

                  

                }    
                if(unreads.length > 0) {
                     this.read(unreads);  
                  
                     bus.$emit('countunreads', this.job.job_id);   
                }
                
                      
                return data;
        },

        formatNewMessage(data, last, id) {
            
                var msg = {};
                    msg.message = data.message;

                msg.fromjob = data.job;
                msg.fromjob.jobable = data.jobable;
                msg.from_job_id = data.job.id;
  
                if(msg.user_id != id)
                    msg.isGuest = true;
                if(last) {
                    if(msg.message.user_id == last.message.user_id)
                        msg.isHeader = false;
                    else 
                        msg.isHeader = true;
                }
                else
                    msg.isHeader = true;
               
          

                if(msg.fromjob.jobable_type == 'project') {
                    
                    if(msg.fromjob.jobable.user_id == msg.user_id) {
                        
                        msg.title = 'Client';                                        
                    }                      
                    else
                        msg.title = 'Project Manager';
                }                    

                if(msg.fromjob.jobable_type == 'section')
                    msg.title = 'Section Controller';
                
                if(msg.fromjob.jobable_type == 'package')
                    msg.title = 'Surveyor';

                return msg;

        },
        scrollFunction() {           
          
            if ($('#chatroom-log').scrollTop() < 1){
                this.scrollBottom = false; 
                if(this.messages.length > 0)   
                    var last_id = this.messages[0].id;
                else
                    var last_id = null;

                this.oldHeight = this.$el.querySelector("#chatroom-log").scrollHeight;
                var params = {                
                    job_id: this.job.job_id,                  
                    private: this.job.private,
                    last_id: last_id,
                    channel: 2
                };
                this.loading = true;
				axios.get('/api/messages/jobs', {params}
                
                )
				 .then(({data})=>{
                     this.loading = false;
                     if(data.length > 0) {

                        var newMessages = this.formatMessages(data, this.$store.state.user.id);                       
                        this.messages.unshift(...newMessages);                 
    
                     }
               
				 });         
				
			}
		}, 
        read(ids) {
            var data = {
                ids: ids                

            };
            axios.post('/api/messages/read', data)
                 .then(({

                 }))
                 .catch((error)=>{console.log(error)})
        }     

    }

}

</script>
<style lang="scss">
@import './../../../sass/_variables';

.message img {
    max-width: 300px;
    max-height: 150px;
}
#chat-messages {
    height: 110%;
}
.message  {
     /*margin-top: 5px;*/
 }
.msg-content {
    /*padding: 0px 7px;*/
} 
.message .msg-content {
   position: relative;
   /*padding: 5px 12px;*/
   width: 100%;
   /*border-radius: 5px;*/
   display: inline-block;
}
.message:not(.owner) .msg-content:not([class*=bg-]) {
/*background-color: #f5f5f5;*/
/*border-color: #f5f5f5;*/
}

 .owner .msg-content:not([class*=bg-]) {
    color: $brand-primary;
    /*color: #fff;*/
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

.owner .msg-title {
    color: $brand-primary;
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

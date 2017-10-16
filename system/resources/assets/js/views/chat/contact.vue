<template>   
    <li  :class="{active: isActive}"  class="contactlinks" >        
            <span class="status">
                <span :class='[contact.status=="online"? "text-success": "disabled-color"]'><i class="icon-circle2 fs-9"> </i></span>
            </span>
            <a @click="activate"  >{{contact.first_name}} {{contact.last_name}}</a>
            <span v-if="unreads > 0" class="label pull-right pr-10 bg-warning text-white" >                
                {{unreads}}
            </span>
        
    </li>   
</template>
<script>

export default {
    props: ['contact'],

    data() {
        return {     
               
            isActive: false,     
            unreads: []           
        }
    },

    created() {
        this.countUnreads(); 
        bus.$on('readmessages', (recipient_id)=>{
            if(this.contact.recipient_id == recipient_id)
                this.countUnreads();
        });
        this.startChannel();     
    },
    watch: {
        'contact': function(val){
            if(this.isActive){              
                 bus.$emit('activecontact', val);
            }
        }
    },
    methods: {
         activate(){                            
            var i;
            for(i=0; i < this.$parent.$children.length; i++){                          
                this.$parent.$children[i].isActive = false;
            }
            this.isActive = true;
            bus.$emit('activecontact', this.contact);
            
        },
        countUnreads() {
            axios.get('/api/messages/countunreads', 
                        {params: {
                            sender_id: this.contact.recipient_id,
                            recipient_id: this.contact.sender_id
                        }})
                 .then(({data})=>this.unreads = data)
                 .catch((error)=>console.log(error));
        },

         startChannel() {       

            var pusher = new Pusher('806c86de02562f12daec', {
                cluster: 'ap1',
                encrypted: true
            });
    
            var user_status = pusher.subscribe('user_'+this.contact.recipient_id);            
            user_status.bind('system\\Events\\UserStatus',(data)=>{
                bus.$emit('userstatuschange', data);
               
            }); 

            var new_message = pusher.subscribe(this.contact.recipient_id+'_'+this.contact.sender_id);            
            new_message.bind('system\\Events\\MessagePosted',(data)=>{
                bus.$emit('userstatuschange', data);                 
            });          
   
        }
       


    }
}

</script>


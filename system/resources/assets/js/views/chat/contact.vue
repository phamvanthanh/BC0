<template>   
    <li  :class="{active: isActive}"  class="contactlinks" >        
      
            <a @click="activate"  >{{contact.first_name}} {{contact.last_name}}</a>
            <span  class="label" >                
                {{unreads}}
            </span>
        
    </li>   
</template>
<script>
// import uploader from './uploadFileModal';
export default {
    props: ['contact'],
    components: {
       
    },
    computed: {
       
    },
    data() {
        return {
            pid: this.$route.params.pid,
            showModal: false,           
            isActive: false,
            form: new Form({
                id: null,
                project_id: null,
                name: null
            }), 
            isEdit: false,
            unreads: null,
        }
    },

    created() {
        this.countUnreads();      
    },

    methods: {
         activate(){                            
            var i;
            for(i=0; i < this.$parent.$children.length; i++){                          
                this.$parent.$children[i].isActive = false;
            }
            this.isActive = true;
            bus.$emit('activecontact', this.contact)
            
        },
        countUnreads() {
            axios.get('/api/messages/countunreads', 
                        {params: {
                            sender_id: this.contact.recipient_id,
                            recipient_id: this.contact.sender_id
                        }})
                 .then(({data})=>this.unreads = data)
                 .catch((error)=>console.log(error));
        }


    }
}

</script>


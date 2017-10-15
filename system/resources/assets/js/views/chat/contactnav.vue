<template>
<div id="chatnav">
    <div class="chattab text-center" >
        <a class="active" ref="user_tab" @click='currentTab("user")' ><i class="icon-user"></i></a>
        <a ref="group_tab" @click='currentTab("group")' ><i class="icon-users4"></i></a>
        <a @click="loadContacts" class="pl-20"><i class="icon-spinner9"></i></a>
       
    </div>
    <div class="chatnav-list">
        <ul  v-if='current_tab == "user"'>
            <contact v-for="user in users"
                :contact="user" >           
            </contact>
        </ul>
        <ul v-if='current_tab == "group"'>
        
        </ul>
    </div>
</div>
</template>
<script>
import contact from './contact';

export default {
    data() {
        return {
            users: [],
            current_tab: "user"
        }
    },
    created() {
        this.getContacts();
        // this.startChannel();
        this.$on('userstatuschange', ()=>{
            this.getContacts();
        })
    },
    components: {
        contact
    },
    methods: {
        activate(user) {
            this.$parent.$emit('activeuser', user);
        },
        getContacts() {
            axios.get('/api/messages/address')
                 .then(({data})=>{
                     this.users = data;
                 }) 
        },
        loadContacts() {
            axios.post('api/messages/address/loadcontacts')
                 .then((data)=>{
                     this.getContacts();
                 })
                 .catch((error)=>{
                     console.log(error);
                 })
        },
        currentTab(e) {
                 
            for(var el in  this.$refs){
                this.$refs[el].className = "";
            }
            if(e == "group") {
                this.current_tab = 'group'
                this.$refs.group_tab.className = "active";
            }
                
            else {
                this.$refs.user_tab.className = "active";
                this.current_tab = 'user';
            }
   
        },
       
    }
}

</script>
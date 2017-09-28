<template>
<div class="content-wrapper">
   
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
               <window-heading2></window-heading2> 
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                    <router-link :to="{name:'users.user.info', params: {uid: uid}}" class="btn btn-link btn-float has-text"><i class="icon-info22"></i><span>Info</span></router-link> 
                     <router-link :to="{name:'users.user.roles', params: {uid: uid}}" class="btn btn-link btn-float has-text"><i class="icon-users2"></i><span>Roles</span></router-link>
                     <router-link :to="{name:'users.user.jobs', params: {uid: uid}}" class="btn btn-link btn-float has-text"><i class="icon-list2"></i><span>Jobs</span></router-link>                    
                </div>
            </div>
        </div>

    
    </div>
 
    <div class="content">
      <div :class="{loader:loading}"></div>   
       
      <router-view v-if="user" :class="{hidden:loading}"
            :user="user"
            :uid="user.id">
      </router-view>
      <notify  :warns="$store.state.notifications" ></notify>
    </div>  

</div>

</template>
<script>
import notify from './../../../core/Notify';

export default {
    components: {
        notify
    },
    data() {
        return {
             loading: true,                  
             uid: this.$route.params.uid,      
             user: {
                id: null,
                first_name: null,
                last_name: null,
                nation_id: null,                
                email: null,
                phone: null,
                organization: null,
                status: null 
             }
        }

    },

    created() {
         let _this = this;
         this.getUser(this.uid);   
         this.$on('refreshuser', function(){
            _this.getUser(_this.uid);
         });   
    },

    methods: {
         getUser() {
            axios.get('/api/admin/users/'+this.uid)
                 .then(({data})=>{
                     
                     this.user = data; 
                     this.loading = false;})
                 .catch((error)  => console.log(error));
        },

    }

   



}
</script>

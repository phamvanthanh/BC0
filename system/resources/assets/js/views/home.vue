<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group">
                  
                   
                       
                </div>
            </div>
        </div>    
    </div>

    <div class="content">
       

              
     
    </div>
  

</div>

</template>
<script>
// import dashboard from './dashboard';

export default {


    created() {
        if(this.$store.state.user.roles) {
            if(this.hasRole(this.$store.state.user.roles, 'client')) 
                router.push({name: 'client.projects'})
            
            if(this.hasRole(this.$store.state.user.roles, 'admin')) 
                router.push({name: 'admin.users'})

            if(this.hasRole(this.$store.state.user.roles, 'project_manager')) 
                router.push({name: 'myjobs'})

            if(this.hasRole(this.$store.state.user.roles, 'qto_controller')) 
                router.push({name: 'myjobs'})

            if(this.hasRole(this.$store.state.user.roles, 'surveyor')) 
                router.push({name: 'myjobs'})
            
            if(this.hasRole(this.$store.state.user.roles, 'project_director')) 
                router.push({name: 'desk.projects'})
        }

    
    

    },
    watch: {
        '$store.state.user.roles': function(val) {

           
            if(hasRole(val, 'client')) 
                router.push({name: 'client.projects'})
            
            if(hasRole(val, 'admin')) 
                router.push({name: 'admin.users'})

            if(hasRole(val, 'project_manager')) 
                router.push({name: 'myjobs'})

            if(hasRole(val, 'qto_controller')) 
                router.push({name: 'mytjobs'})

            if(hasRole(val, 'surveyor')) 
                router.push({name: 'myjobs'})

            if(hasRole(val, 'project_director')) 
                router.push({name: 'desk.projects'})

        }
    },
    components: {
        // dashboard,
    },

    methods: {

        hasRole(roles, name) {
            var i;
            for(i = 0; i < roles.length; i++ ) {
                if(roles[i].name == name)
                    return true;
                break;
            }
            return false;
        }

    }
}




</script>
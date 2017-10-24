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
       
        <div class="panel panel-flat">
            <div class="panel-heading">            
                <div class="heading-elements">
                    <div class="form-group">             
                    
                                                        
                
                    </div>
                </div>
            </div>
            
            <div class="panel-body">
    
                <form  @submit.prevent="onSubmit"  @change="form.errors.clear($event.target.name)"   >
                    <div class="row"> 
                        <div class="col-md-4 ">
                            <div class="form-group">
                                <label>First Name: <span class="text-danger">*</span></label>
                                <input name="first_name" v-model="form.first_name" class="form-control">
                            </div>  
                                                                        
                        </div> 
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Last Name: <span class="text-danger">*</span></label>
                                <input name="last_name" v-model="form.last_name" class="form-control">
                            </div>		
                                                                
                        </div>
                    </div>
                    <div class="row">
    
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Email: <span class="text-danger">*</span></label>
                                <input name="email" v-model="form.email"  disabled class="form-control">    
                            </div>    
                            
                        </div>  
                    </div>
                        
                    
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Phone: <span class="text-danger">*</span></label>
                                <input name="phone" v-model="form.phone"   class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Nation: </label>                 
                                <select name="nation_id" v-model="form.nation_id"  class="form-control required">
                                    <option></option>                                    
                                    <option v-for="nation in nations" :value="nation.id">{{nation.name}}</option> 
                                    
                                </select>
                            </div>
                        </div>	
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Organization: </label>
                                <input name="phone" v-model="form.organization"   class="form-control">
                            </div>
                        </div>								
                    </div>
                

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">                                                                     
                                <button type="submit" name="submit" :disabled="form.errors.any()" class="btn btn-primary">Save</button>
                            </div>
                        </div>                                										
                    </div> 	

                        
                </form>
            </div>     
        </div>
              
     <notify :warns="$store.state.notifications"></notify>
    </div>
     

</div>

</template>
<script>

import notify from './../../core/Notify';

export default {


    data() {
       return {
         
           nations: [],
           form: new Form({
               id: this.$store.state.user.id,
               first_name: this.$store.state.user.first_name,
               last_name: this.$store.state.user.last_name,
               email: this.$store.state.user.email,
               phone: this.$store.state.user.phone,
               nation_id: this.$store.state.user.nation_id,
               organization: this.$store.state.user.organization,
               status: this.$store.state.user.status
           })
       }
    

    },
    created() {
           
           this.getNations(); 
        
    },
    computed: {
        user: {
            get() {
                return  this.$store.state.user;
            },
            set() {

            }
        }
    },
    components: {
        notify,
    },

    methods: {

        onSubmit() {
            this.form.post('/api/admin/users')
                    .then(({data})=>{
                      
                       notice(this.form.notifications, 6000);
                    })
                    .catch(errors => {
                       notice(this.form.notifications, 6000);
                    })
            
        },
        getUser() {
            axios.get('/loggedInUser')
                .then(({data})=>{               
                    this.user = data;  
                })
                .catch((error)=>console.log(error));  
        },
        getNations() {
            axios.get('/api/admin/nations')
                .then((data)=>{this.nations = data.data })
        }, 
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
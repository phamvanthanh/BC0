<template>


    <div class="sub-panel panel-flat">
        <div class="panel-heading">
           
            <div class="heading-elements">
                <div class="heading-btn">
                    <div class="form-group">
                        <div class="switch-box">												  
                            <label class="switch ">	
                                <span class="switch-label">Edit</span>																										
                                <input v-model="editMode" @click="editToggle" type="checkbox" name="editMode" >                                    
                                <div class="slider"></div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="panel-body">
            <div class="col-md-12" v-if="editMode">
                <form method="post" @submit.prevent="onSubmit" >                                   
                  
                        <div class="col-md-3 pl-5"> 
                            <div class="form-group">
                                <label >User:</label>
                                    <input :value="full_name" disabled  class="form-control" > 
                            </div>
                        </div>
                        <div class="col-md-3"> 
                            <div class="form-group">
                                <label >Email:</label>
                                    <input :value="user.email" disabled  class="form-control" > 
                            </div>
                        </div>
                        
                        <div class="col-md-4"> 
                            <div class="form-group">
                                <label >Role:</label>
                                <select v-model="form.role_id"   type="text" placeholder="Role" class="form-control">
                                    <option></option>
                                    <option :value="role.id" v-for="role in allRoles" >{{role.name}}</option>

                                </select>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="form-group">
                                <label class="transparent" >*</label>
                                <button type="submit" class="btn btn-primary form-control">Save</button>
                            </div>
                        </div>    
                        <div class="col-md-1">
                            <div class="form-group">
                                <label class="transparent" >*</label>
                                <button type="button" @click="reset" class="btn btn-default form-control">Clear</button>
                            </div>
                        </div>                       
                                  			
                </form>
            </div>
            <div  class="col-md-12" >
                <v-client-table 
                    :data="user.roles" 
                    :columns="columns" 
                    :options="options">
                    <template slot="actions" scope="props">
                        <ul class="icons-list" >          
                            <li class="text-danger-600" >
                                <a v-on:click="deleteUserRole(props.row)" >Detach</a>                   
                            </li>
                        </ul>
                    </template>
                </v-client-table>
            </div>
        </div>
        
        
        
    </div>


</template>
<script>


import  ClientTable from 'vue-tables-2';



export default {
     props: ['user'],
    data() {
        return {
             editMode: (localStorage.getItem('edituserrole') == "true"? true: false),         
      
             form: new Form({                 
                 user_id: null,
                 role_id: null,                    
                 
             }),          

             allRoles: [],

             columns: ['id', 'name', 'display_name', 'description', 'actions'],
             options: {

                headings: {

                    display_name: 'Display name',  
                    actions: ''                
                },
                
                skin: 'table-hover',
                
                texts: {
                    filter: ''
                },
                
                columnsClasses: {
                    
                    id: 'w-70',
                    name: 'w-150',
                    display_name: 'w-150',
                    description: 'column-expanded',
                    actions: 'text-right w-50 action',
                },
                
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                },
             }
         
        
        }

    },
    
    created() {    
  
        this.getRoles();
        var _this = this;
   
        bus.$on('edituserrole', function(e){                   
            for(let property in e){
                 _this.form[property] = e[property];
            }
        })
    },
    computed: {
     
        full_name() {
            return this.user.first_name + ' '+ this.user.last_name;
        }      
    },

    methods: {
        editToggle() {
            localStorage.setItem('assignmentedit', this.editMode);
        },
        onSubmit() { 
            this.form.user_id = this.user.id;
            this.form.post('/api/admin/users/attachrole')
                     .then(({data})=>{
                         this.$parent.$emit('refreshuser');
                         notice(this.form.notifications, 6000);                         
                     })
                     .catch(({error})=>{
                         notice(this.form.notifications, 6000);
                    })
        },

      
        getRoles() {
            axios.get('/api/admin/roles')
                 .then(({data})=>{this.allRoles = data })
        }, 
      
        deleteUserRole(e) {
      
            var yes = confirm('You are about to delete the role permanently. Deleting the role will disabled users assigned to the role.');
            if(yes){   
                var form = new Form(e.pivot);            
                form.post("/api/admin/users/"+form.user_id+"/roles/detach")
                         .then(({data})=>{                             
                             this.$parent.$emit('refreshuser');
                             notice(form.notifications, 5000);
                         })
                         .catch((error)=>{ 
                             notice(form.notifications, 5000);
                         })               
            }

        },
      
        reset() {
            this.form.role_id = null;
        }      

    }


}
</script>

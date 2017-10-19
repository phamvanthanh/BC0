<template>
<div class="content-wrapper">

    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>       
            </div>
            <div class="heading-elements">
                <div class="heading-btn-group" >
                   
                </div>
            </div>
        </div>    
    </div>
    <div class="content">      
          
        <div class="panel panel-flat">
            <div class="panel-heading">             
                <div class="heading-elements">
                    <div class="heading-btn">
                        <div class="form-group">
                            <div class="switch-box">												  
                                <label class="switch ">	
                                    <span class="switch-label">Edit</span>																										
                                    <input v-model="editMode" @click="editToggle"type="checkbox" name="edit" >
                                    
                                    <div class="slider"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
          
            <div class="panel-body">
                <div class="col-md-12" v-if="editMode">
                    <form @submit.prevent="onSubmit" method="post" >
                    
                        <div class="col-sm-2 pl-5">
                            <div class="form-group">
                                <label>Name: <span class="text-danger">*</span></label>
                                <input v-model="form.name" class="form-control">
                            </div>
                        </div>
                         <div class="col-sm-2">
                            <div class="form-group">
                                <label>Display Name: <span class="text-danger">*</span></label>
                                <input v-model="form.display_name" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label>Description: <span class="text-danger">*</span></label>
                                <input v-model="form.description" class="form-control required">
                            </div>
                        </div>
                        <div class="col-sm-1">
                            <div class="form-group">
                                <label class="transparent" >*</label>
                                <button type="submit" class="btn btn-primary form-control">Save</button>
                            </div>
                        </div>
                        <div class="col-sm-1">
                            <div class="form-group">
                                <label class="transparent" >*</label>
                                <button @click="reset" type="button" class="btn btn-default form-control">Clear</button>
                            </div>
                        </div>
                    </form>
                     <div class="col-md-12 horizontal-divider mb-10"></div>
                </div>
                <div class="col-md-12">
                      <v-client-table 
                            :data="roles" 
                            :columns="columns" 
                            :options="options">
                            <template slot="actions" scope="props">            
                                <ul class="icons-list" >
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                            <i class="icon-menu7"></i>
                                        </a>

                                        <ul class="dropdown-menu  dropdown-menu-right">
                                            <li><router-link :to="{name: 'role.permissions', params: {rid: props.row.id}}" class="text-primary"><i class="icon-accessibility"></i> Permissions</router-link></li>                                        
                                            <li><a @click="editRole(props.row)"  class="text-primary" ><i class="icon-pencil3"></i> Edit</a></li>
                                            <li><a @click="deleteRole(props.row)" class="text-danger" ><i class="icon-trash-alt"></i> Delete</a></li>
                                        </ul>
                                    </li>
                                </ul>
                                
                            </template>
                      </v-client-table>
 
                </div>
            </div>
           
           
         
        </div>  
        <notify :warns="$store.state.notifications"></notify>  
    </div>
 
    
</div>

</template>
<script>


import notify from './../../../core/Notify';

export default {
  
    data() {
        return {
           
             editMode: (localStorage.getItem('rolesedit') =="false"? false: true),         
             form: new Form({
                 id: null,
                 name: null,
                 display_name: null,
                 description: null,                
                 
             }),
             roles: [],
             columns: ['id', 'name', 'display_name', 'description', 'actions'],
             options: {

                headings: {
                    actions: ''
                },
             
                columnsClasses: {
                    id: 'w-70',
                    name: 'w-200',
                    display_name: 'w-200',
                    description: 'column-expanded',                     
                    actions: 'text-right w-40 action',
                },
                sortable: ['id', 'name', 'display_name', 'description'],
             }        
        }

    },
    created() {        
        this.getRoles(this.pid);
        var _this = this;
        bus.$on('refreshroles', function(){
            _this.getRoles(_this.pid);
        });
        bus.$on('editrole', function(e){
            for(let property in e){
                _this.form[property] = e[property];
            }
        })
    },
    components: {
        notify
    },

    methods: {
        editToggle() {
            localStorage.setItem('rolesedit', this.editMode);
        },
        onSubmit() { 
            this.form.post('/api/admin/roles')
                     .then(({data})=>{                        
                         notice(this.form.notifications, 5000);
                        this.form.reset();
                         this.getRoles(this.pid)})
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);})

        },
        getRoles(pid) {
            axios.get('/api/admin/roles')
                 .then((data)=>{
                     this.roles = data.data;
                     this.loading = false; })
        }, 
    
     
        editRole(e) {
            bus.$emit('editrole', e);
        },
        
        deleteRole(e) {

            this.form.id = e.id;          
            var yes = confirm('You are about to delete the role permanently. Deleting the role will disabled users assigned to the role.');
            if(yes){               
                this.form.post("/api/admin/roles/delete")
                        .then(({data})=>{
                            notify(this.form.notifications, 5000);
                            bus.$emit('refreshroles')})
                        .catch((error)=>{ 
                            notify(this.form.notifications, 5000);})               
            }          
        },
        reset() {
            this.form.reset();
        }
        

    }


}
</script>

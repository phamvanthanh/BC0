<template>
<div class="content-wrapper">
    
   
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <window-heading2></window-heading2> 
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                   
                </div>
            </div>
        </div>    
    </div>
   
    <div class="content">
        <div :class="{loader:loading}"></div>
        <div :class="{hidden:loading}" class="panel panel-flat">
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
                        :data="permissions" 
                        :columns="columns" 
                        :options="options">
                        <template slot="actions" scope="props">
                            <ul class="icons-list" >
                                <li class="dropdown" >
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                        <i class="icon-menu7"></i>
                                    </a>
                                    <ul class="dropdown-menu  dropdown-menu-right">                                
                                        <li><a @click="editPermission(props.row)" class="text-primary" ><i class="icon-pencil3"></i> Edit</a></li>
                                        <li><a @click="deletePermission(props.row)" class="text-danger" ><i class="icon-trash-alt"></i> Delete</a></li>
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

import  ClientTable from 'vue-tables-2';
import notify from './../../../core/Notify';

export default {
  
    data() {
        return {
             loading: true,
             editMode: (localStorage.getItem('permissionedit') =="false"? false: true),
         
             form: new Form({
                 id: null,
                 name: null,
                 display_name: null,
                 description: null,                
                 
             }),
             permissions: [],
             columns: ['id', 'name', 'display_name', 'description', 'actions'],
             options: {

                headings: {
                     actions: ''
                },
                 
                skin: 'table-hover',
                texts: {
                    filter: ''
                },
                columnsClasses: {
                    id: 'w-70',
                    name: 'w-200',
                    display_name: 'w-200',
                    description: 'column-expanded',                     
                    actions: 'text-right w-40 action',
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                },
                perPage: 25,
                perPageValues: [10,25,50,100]

             }
        
        }

    },
    ready() {
        // this.loading = true;
    },
    created() {        
        this.getPermissions();
        var _this = this;
        bus.$on('refreshpermissions', function(){
            _this.getPermissions(_this.pid);
        });
        bus.$on('editpermission', function(e){
            for(let property in e){
                _this.form[property] = e[property];
            }
        })
    },

    components: {

           notify,
   
    },
    methods: {
        editToggle() {
            localStorage.setItem('permissionedit', this.editMode);
        },
        onSubmit() { 
            this.form.post('/api/admin/permissions')
                     .then(({data})=>{
                         notice(this.form.notifications, 6000)
                         this.form.reset();                      
                         this.getPermissions(this.pid)})
                     .catch(({error})=>{
                         notice(this.form.notifications, 6000)})

        },
        getPermissions() {
            axios.get('/api/admin/permissions')
                 .then((data)=>{
                     this.permissions = data.data;
                     this.loading = false;
                 })
        }, 
        deletePermission(e) {
            this.form.id = e.id;          
            var yes = confirm('You are about to delete the permission permanently. Deleting the permission will disabled users assigned to the permission.');
            if(yes){               
                this.form.post("/api/admin/permissions/delete")
                         .then(({data})=>{
                             bus.$emit('refreshpermissions')})
                         .catch((error)=>{ 
                             this.$store.commit('loadNotifications', this.form.notifications)})               
            }

        },
        editPermission (e) {
            if(!this.editMode)
                this.editMode = true;
            bus.$emit('editpermission', e);

        },
        reset() {
            this.form.reset();
        },
       
      

    }


}
</script>

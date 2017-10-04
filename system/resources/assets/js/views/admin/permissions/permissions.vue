<template>
<div class="content-wrapper">
    
   
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
           
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

                      <v-server-table
                        url="/api/admin/permissions" 
                        :columns="columns" 
                        :options="options"
                        ref="permission_table"
                        
                      >
                            <template slot="actions" scope="props">
                                <ul class="icons-list" >
                                    <li class="dropdown" >
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                            <i class="icon-menu7"></i>
                                        </a>
                                        <ul class="dropdown-menu  dropdown-menu-right">                                
                                            <li><a @click="editPermission(props.row)" class="text-primary" ><i class="icon-pencil3"></i> Edit</a></li>
                                            <li><a @click="copyPermission(props.row)" class="text-primary" ><i class="icon-copy3"></i> Copy</a></li>
                                            <li><a @click="deletePermission(props.row)" class="text-danger" ><i class="icon-trash-alt"></i> Delete</a></li>
                                        </ul>
                                    </li>
                                </ul>    
                            </template>
                     
                    </v-server-table>              
                   
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
             loading: false,
             editMode: (localStorage.getItem('permissionedit') =="false"? false: true),
         
             form: new Form({
                 id: null,
                 name: null,
                 display_name: null,
                 description: null,                
                 
             }),
             permissions: [],           
             columns: [ 'id', 'name', 'display_name', 'description', 'actions'],
             
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
           
                sortable: ['id', 'name', 'display_name', 'description'],
                perPage: 25,
                perPageValues: [10,25,50,100],
               
                // responseAdapter: function responseAdapter(resp) {
                //     return {
                //         data: resp.data,
                //         count: resp.total
                //     };
                // },

             }
        
        }

    },

    mounted() {        
      
        // this.$on('editpermission', (e)=>{
          
        // })
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
                         this.$refs.permission_table.refresh();                     
                        
                         })
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
                             this.$refs.permission_table.refresh(); 
                             })
                         .catch((error)=>{ 
                             this.$store.commit('loadNotifications', this.form.notifications)})               
            }

        },
    
        editPermission (e) {           
            if(!this.editMode)
                this.editMode = true;
            for(let property in e){
                this.form[property] = e[property];
            }

        },
        copyPermission (e) {           
           this.editPermission(e);
           this.form.id = undefined;

        },
        reset() {
            this.form.reset();
        },
       
      

    }


}
</script>

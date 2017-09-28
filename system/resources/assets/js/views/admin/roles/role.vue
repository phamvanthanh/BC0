<template>
<div class="content-wrapper">
    <!-- Page header -->
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
                <div class="row" v-if="editMode">
                    <form @submit.prevent="onSubmit" method="post" >                    
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label>Role: <span class="text-danger">*</span></label>
                                <input :value="role.display_name" disabled class="form-control">
                                <input v-model="form.role_id" disabled class="form-control hidden">
                            </div>
                        </div>
                         <div class="col-sm-3">
                            <div class="form-group">
                                <label>Permission: <span class="text-danger">*</span></label>
                                <select v-model="form.permission_id"   type="text" placeholder="Role" class="form-control">
                                        <option></option>
                                        <option :value="perm.id" v-for="perm in permissions" >{{perm.display_name}}</option>

                                </select>
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
                                <button type="button" @click="reset" class="btn btn-default form-control">Clear</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="wrapper">
                     <v-client-table 
                            :data="role.perms" 
                            :columns="columns" 
                            :options="options">
                            <template slot="actions", scope="props">                                
                                <a @click="detachPermission(props.row)" >Detach</a>
                            
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
            loadedRole: false,
            loadedPermissions: false,
           
             editMode: (localStorage.getItem('rolesedit') =="false"? false: true),
             rid : this.$route.params.rid,
             role: {
                  id: null,
                  perms: [],
             },
             form: new Form({
                role_id: null,
                permission_id: null            
                 
             }),           
             permissions: [],

             columns: ['id', 'name', 'display_name', 'description', 'actions'],

             options: {
                 headings: {
                    actions: ''
                 },
                 skin: 'table-hover',
                 texts: {
                    filter: 'Filter: '
                 },
                 columnsClasses: {
                    id: 'w-70',
                    name: 'w-200',
                    display_name: 'w-200',
                    description: 'column-expanded',                     
                    actions: 'text-right w-70 action',
                 },
                 sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                 },
             }            
        
        }

    },
    computed: {
        loading: {
            get() {
                return !(this.loadedRole && this.loadedPermissions);
            },
            set() {

            }
        }
    },

    created() {        
        this.getRole(this.rid);
        this.getPermissions();
        var _this = this;
        bus.$on('refreshrole', function(){
            _this.getRole(_this.rid);
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
            localStorage.setItem('rolsedit', this.editMode);
        },
        onSubmit() { 
            this.form.role_id = this.role.id;
            if(!this.form.permission_id) {
                 notice({status: 400, data:['Permission is required.']}, 6000);
                 return;
            }
            this.form.post('/api/admin/roles/permissions')
                     .then(({data})=>{  
                         notice(this.form.notifications, 5000);
                         this.form.permission_id = null,                       
                         this.getRole(this.rid)
                     })
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);})

        },
        getRole(pid) {
            axios.get('/api/admin/roles/'+this.rid)
                 .then((data)=>{                     
                     this.role = data.data;              
                     this.loadedRole = true;
                 })
                 .catch(({error})=>{
                     console.log(error);
                 })
        }, 

        getPermissions() {
            axios.get('/api/admin/permissions')
                 .then((data)=>{
                     this.permissions = data.data;
                     this.loadedPermissions = true; })
        }, 
         detachPermission(e) {
            if(confirm("Detaching permission may effect users' authorities"))
                var form = new Form(e.pivot);
                    form.post('/api/admin/roles/permissions/detachPermission')
                        .then(({data})=>{
                            notice(form.notifications, 5000);
                            bus.$emit('refreshrole')
                        })
                        .catch((error)=>{
                            notice(form.notifications, 5000);
                            
                        })
            return;
        

        },
        reset() {
            this.form.permission_id = null;
        },

        goBack() {
            router.go(-1);
        },
        forward() {
            router.go(1);
        }
        

    }


}
</script>

<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                    <router-link to="/admin/users/new" class="btn btn-link btn-float has-text"><i class="icon-pencil3"></i><span>New</span></router-link> 

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
                            
                        </div>
                    </div>
                </div>
            </div>
          
            <div class="panel-body">
            
                <div class="col-md-12">

                     <v-server-table 
                            url="/api/admin/users"                  
                       
                            ref="user_table"
                        
                            :columns="columns" 
                            :options="options">
                         
                            <template slot="full_name" scope="props">
                                {{props.row.first_name}} {{props.row.last_name}}
                            </template>
                            <template slot="actions" scope="props">
                                <router-link class="text-primary" :to="{name: 'users.user.info', params: {uid: props.row.id}}"><i class="icon-unfold"></i></router-link>
                                 
                            </template>
                            
                   
                      </v-server-table>

                </div>
            </div>        
        </div>
       
    </div>
    <notify :warns="$store.state.notifications"></notify>
</div>

</template>
<script>

import notify from './../../../core/Notify';


export default {
  
    data() {
        return {
            loading: false,
             editMode: (localStorage.getItem('usersedit') =="false"? false: true),
         
             form: new Form({
                 id: null,
                 first_name: null,
                 last_name: null,
                 nation_id: null,                
                 email: null,
                 phone: null,
                 organization: null,
                 status: null                
                 
             }),

             users: [],
             columns: ['id', 'full_name',  'email', 'phone', 'organization', 'nation_abbr', 'status', 'actions'],
             options: {
             
                headings: {
                    full_name: 'Name',
                    nation_abbr: 'Nation',
                    origanization: 'Ogr',
                    actions: ''
                },

                templates: {      
                    status: 'status'
                },
                
                sortable: ['id', 'full_name', 'email', 'phone', 'organization', 'nation_abbr', 'status'],
                columnsClasses: {
                  
                    id: 'w-70',
                    full_name: 'column-expanded',
                    client: 'w-150',
                    nation_abbr: 'w-70',
                    email: 'w-250',
                    phone: 'w-125',                 
                    organization: 'w-200',
                    status: 'w-70',   
                    actions: 'text-right w-40 action',
                },
          
                perPage: 25,
                // responseAdapter: function responseAdapter(resp) {
                 
                //     return {
                //         data: resp,
                //         count: resp.total
                //     };
                // },
                
             }
        
        }

    },

    components: {
        notify,
    },

    created() {        
        // this.getUsers(this.pid);
        // var _this = this;

        // bus.$on('refreshusers', function(){
        //     _this.getUsers(_this.pid);
        // });

        bus.$on('edituser', function(e){ 
                    
            for(let property in e){
                _this.form[property] = e[property];
            }
        })
    },


    methods: {

        editToggle() {
            localStorage.setItem('usersedit', this.editMode);
        },

        onSubmit() { 
            this.form.post('/api/admin/users')
                     .then(({data})=>{
                         notice(this.form.notifications, 6000);
                         this.form.reset();
                         this.getUsers(this.pid)
                     })
                     .catch(({error})=>{
                        notice(this.form.notifications, 6000);  
                     })

        },

        // getUsers(pid) {
        //     axios.get('/api/admin/users')
        //          .then(({data})=>{
        //             this.users = data;
        //             this.loading = false; 
        //          })
        // }, 
        editUser(e) {
            if(!this.editMode)
                this.editMode =true;
            bus.$emit('edituser', e);
        },
        clearForm() {
            this.form.reset();
        },   
        

    }


}
</script>

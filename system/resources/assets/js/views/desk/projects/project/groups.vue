<template  >

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
        <div class="row" v-if="editMode">
            <form @submit.prevent="onSubmit" method="post" >            
                <div class="col-sm-2">
                    <div class="form-group">
                        <label>Name: <span class="text-danger">*</span></label>
                        <input v-model="form.name" class="form-control required">
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="form-group">
                       
                         <label>Start date: </label>                 
                         <datepicker name="from_date" v-model="form.from_date"  ></datepicker>   
                      
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="form-group">
                        <label>To date: <span class="text-danger">*</span></label>
                        <datepicker name="to_date" v-model="form.to_date"  ></datepicker>   
                       
                       
                    </div>
                </div>
                 <div class="col-md-6">                    
                    <div class="form-group">
                        <label>Status:</label> 
                            <div class="input-group">                
                                <label class="radio-inline"><input type="radio"   value="deactive" v-model="form.status" checked>Deactive</label>
                                <label v-if="form.id" class="radio-inline"><input type="radio"   value="active" v-model="form.status" >Active</label>
                                <label v-if="form.id" class="radio-inline"><input type="radio"   value="suspended" v-model="form.status" >Suspended</label>
                            </div>
                    </div>
                </div>   
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>Brief:</label>
                        <textarea v-model="form.description" class="form-control"></textarea>
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
                        <button type="button" @click="clearForm" class="btn btn-default form-control">Clear</button>
                    </div>
                </div>
            </form>
        </div>
    
        <v-client-table
            :data="groups"
            :columns="columns"
            :options="options">

            <template slot="actions" scope="props">            
                <ul class="icons-list" >
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="icon-menu7"></i>
                        </a>

                        <ul class="dropdown-menu  dropdown-menu-right">
                            <li><router-link class="text-primary" :to="{name:'desk.project.group.packages', params: {gid: props.row.id}}"><i class="icon-arrow-right7"></i> Packages</router-link></li>
                            <li><router-link class="text-primary" :to="{name:'desk.project.group.gwbs', params: {gid: props.row.id}}"><i class="icon-arrow-right7"></i> Gwbs</router-link></li>
                            <li><a @click="editGroup(props.row)" class="text-primary"  ><i class="icon-pencil3"></i> Edit</a></li>
                            <li><a @click="deleteGroup(props.row)" class="text-danger" ><i class="icon-trash-alt" ></i> Delete</a></li>
                        </ul>
                    </li>
                </ul>
                
            </template>
                    
        </v-client-table>
    </div>
</div>
     
     

</div>
</template>
<script>


import pwbsg    from './../../../elements/pwbsg';
import gwbs     from './../../../elements/gwbs';

import datepicker     from './../../../elements/Datepicker';

// import datepicker from 'vue-date';
import  ClientTable from 'vue-tables-2';





export default {  
    data() {
        return {             
                     
             group_id: this.$route.params.gid,

             isGrouping: false,
             editMode: (localStorage.getItem('groupsedit') =="false"? false: true),  
             pid: this.$route.params.pid,
             form: new Form({ // New group form
                 id: null,
                 project_id: this.$route.params.pid,
                 name: null,
                 description: null,             
                 from_date: null,
                 to_date: null,
                 status: null
                                 
             }), 
             activeGroup: null,
             groups: [],        
             columns: ['id', 'name', 'description', 'from_date', 'to_date', 'status',  'actions'],
             options: {
                headings: {
                    id: 'Id',
                    name: 'Name',
                    from_date: 'From',
                    to_date: 'To',
                    description: 'Desc',
                    status: 'Status', 
                    gwbs: 'Gwbs',                 
                    actions: ''         
                  
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'
                },
                templates: {
                    
                     status: 'status'
                },            
             
                columnsClasses: {
                    id: 'w-70',
                    name: 'w-150',
                    description: 'column-expanded',                
                    from_date: 'w-80',
                    to_date: 'w-80',              
                    status: 'w-70',
                    actions: 'text-right w-40 action'                   

                
                },

                skin: 'table-hover',
                texts: {
                    filter: 'Filter: '
                }

            },
        }
    },

    created() {        
          
        this.getGroups(this.pid);  
        var _this = this;     
        bus.$on('refreshgroups', function(){
            _this.getGroups(_this.pid);
        });
        bus.$on('editgroup', function(e){
            for(let property in e){
              
                _this.form[property] = e[property];
            }
        });    

    },
    computed: {
        notifications() {
            return this.$store.state.notifications
        },
        
    },

    components: {    
           
        datepicker
    },
    methods: {
        editToggle() {
            localStorage.setItem('groupsedit', this.editMode);
        },
        onSubmit() { 
            this.form.post('/api/projects/'+this.pid+'/groups')
                     .then(({data})=>{                        
                        
                         notice(this.form.notifications, 5000);                                              
                         this.getGroups(this.pid);
                         this.form.reset();

                         })
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);
                         })

        },
        getGroups(pid) {
            axios.get('/api/projects/'+pid+'/groups')
                 .then((data)=>{this.groups = data.data.map(function(e){
                     e.from_date = e.job.from_date;
                     e.to_date = e.job.to_date;
                     e.status  = e.job.status;
                     return e;
                 }) })
        }, 
    
        clearForm() {
            this.form.reset();
        },
        editGroup(e) {
            if(!this.editMode)             
                this.editMode = true;

            bus.$emit('editgroup', e);
        },
        
        deleteGroup(e) {            
            this.form.id = e.id;         
            var yes = confirm('You are about to delete the group permanently. All system will not be able to use the group.');
            if(yes){  
                if(e.awarded =='awarded') {
                    alert('This group has been awarded as a job and cannot be deleted');
                    return;
                }             
                this.form.post("/api/projects/"+this.form.project_id+"/groups/delete")
                         .then(({data})=>{
                             bus.$emit('refreshgroups')})
                         .catch((error)=>{ 
                             this.$store.commit('loadNotifications', this.form.notifications)})               
            }
        },
       

   
    }
}
</script>
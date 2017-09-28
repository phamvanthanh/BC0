<template  >          
    <div class="wrapper">
        <div class="row" v-if="editMode">
            <form @submit.prevent="onSubmit" method="post" >
        
                <div class="col-sm-2">
                    <div class="form-group">
                        <label>Name: <span class="text-danger">*</span></label>
                        <input v-model="form.name" class="form-control required">
                    </div>
                </div>
                <div class="col-sm-1">
                    <div class="form-group">
                        <label>Area: <span class="text-danger">*</span></label>
                        <input v-model="form.area" class="form-control required">
                    </div>
                </div>
                <div class="col-sm-1">
                    <div class="form-group">
                        <label>Comp.: <span class="text-danger">*</span></label>
                        <select v-model="form.complexity" class="form-control required">
                            <option value="1">1</option>
                            <option value="1.25">1.25</option>
                            <option value="1.5">1.5</option>
                            <option value="1.75">1.75</option>
                            <option value="2">2</option>
                            <option value="2.25">2.25</option>
                            <option value="2.5">2.5</option>                        
                        </select>
                    </div>
                </div>
                <div class="col-sm-2">
                    <div class="form-group">               
                        <label>From date: <span class="text-danger">*</span></label>
                        <datepicker name="from_date"  v-model="form.from_date" format="YYYY-MM-DD"  ></datepicker>
                
                    </div>
                </div>
                <div class="col-sm-2"> 
                    <div class="form-group">               
                        <label>To date: <span class="text-danger">*</span></label>
                        <datepicker name="to_date"  v-model="form.to_date"  ></datepicker>
            
                    </div>
                </div>
                <div class="col-md-4">                    
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
                        <label>Description: </label>
                        <textarea v-model="form.description"  placeholder="Place a brief description" class="form-control required"></textarea>
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
                        <button @click="resetForm" type="button"  class="btn btn-default form-control">Clear</button>
                    </div>
                </div>
            </form>
        </div>
        <div > 
            <v-client-table
                :data="packages"
                :columns="columns"
                :options="options">
                <template slot="actions" scope="props"> 
                    <ul class="icons-list" >
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-menu9"></i>
                            </a>

                            <ul class="dropdown-menu  dropdown-menu-right">
                                <li><a @click="editPackage(props.row)" ><i class="icon-pencil3"></i> Edit</a></li>
                                <li><a @click="deletePackage(props.row)" ><i class="icon-trash-alt"></i> Delete</a></li>
                            
                            </ul>
                        </li>
                    </ul>
                </template>
            </v-client-table>
            
        </div>
        
    </div>
</template>
<script>

import datepicker     from './../../../../elements/Datepicker';
import ClientTable from 'vue-tables-2';



export default {
    props: {
        gid: null,
        editMode: false
    },  
    data() {
        return {
             pid: this.$route.params.pid,
             form: new Form({
                 id: null,
                 group_id: null,
                 name: null,
                 area: null,
                 complexity: null,
                 description: null,        
                 from_date: null,
                 to_date: null,
                 status: 'deactive'
                                                
             }),
             dateFormat:"yyyy-MM-dd",
             groups: [],
             packages: [],
             columns: ['id', 'name', 'description', 'area', 'complexity', 'from_date', 'to_date', 'status', 'actions'],
             options: {
                 headings: {
                     description: 'Desc.',
                     complexity: 'Comp.',
                     from_date: 'From',
                     to_date: 'To',
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
                    area: 'w-70',
                    complexity: 'w-70',
                    from_date: 'w-80',
                    to_date: 'w-80',              
                    status: 'w-70',
                    actions: 'text-right w-40 action'                   

                
                },

                 skin: 'table-hover',
                 texts: {
                    filter: 'Filter: '
                 }
             }        
        }
    },
    created() {        
        this.getPackages(this.gid);
        this.getGroups(this.pid);
        var _this = this;
        bus.$on('refreshpackages', function(){
            _this.getPackages(_this.gid);
        });
        bus.$on('editpackage', function(e){
            for(let property in e){
                _this.form[property] = e[property];
            }
        })
    },

    computed: {
        notifications() {
            return this.$store.state.notifications
        },
        hasPackages() {
            return (this.packages.length > 0)
        }
        
    },
    components: {
        datepicker,
        
    },
    methods: {
        editToggle() {
            localStorage.setItem('packagesedit', this.editMode);
        },
        onSubmit() { 
            this.form.group_id = this.gid;
       
            this.form.post('/api/projects/'+this.pid+'/packages')
                     .then(({data})=>{
                         notice(this.form.notifications, 5000);
                         this.form.reset();
                         this.getPackages(this.gid)})
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);})

        },
        resetForm() {
            this.form.reset();
        },
        getPackages(gid) {
            if(gid)
            axios.get('/api/projects/groups/'+gid+'/packages')
                 .then((data)=>{this.packages = data.data.map(function(e){
                     e.from_date = e.job.from_date;
                     e.to_date =  e.job.to_date;
                     e.status = e.job.status;
                     return e;
                 }) })
        }, 
        getGroups(pid) {
            axios.get('/api/projects/'+pid+'/groups')
                 .then((data)=>{this.groups = data.data })
        }, 
        formNotify() {
            this.$store.commit('loadNotifications', this.form.notifications)
            
        },
        
        editPackage(e) {
            bus.$emit('editpackage', e);            

        },

        deletePackage(e) {
            this.form.id = e.id;
            
            if(e.awarded == 'awarded') {
                alert('This package has been awareded as a job and cannot be deleted');
                return;
            }

            var yes = confirm('You are about to delete the link permanently. All system will not be able to access the link.');
            if(yes){               
                this.form.post("/api/projects/"+this.pid+"/packages/delete")
                         .then(({data})=>{
                             bus.$emit('refreshpackages')})
                         .catch((error)=>{ 
                                console.log(error);
                })               
            }
        }
 
        

    }


}
</script>
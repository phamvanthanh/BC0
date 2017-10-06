<template  >          
    <div class="wrapper">
        <div :class="{loader:loading}"></div>      
        <div :class="{hidden:loading}" class="col-md-12" v-if="editMode">
            <form @submit.prevent="onSubmit" method="post" >
        
                <div class="col-sm-2 pl-5">
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
                        <datepicker name="from_date"  
                                    :min="min_date"
                                    :max="max_date"
                                    v-model="form.from_date"
                        ></datepicker>
                
                    </div>
                </div>
                <div class="col-sm-2"> 
                    <div class="form-group">               
                        <label>To date: <span class="text-danger">*</span></label>
                        <datepicker name="to_date" 
                                    :min="min_date"
                                    :max="max_date"
                                     v-model="form.to_date"  >
                        </datepicker>
            
                    </div>
                </div>
                <div class="col-md-4 ">                    
                        <div class="form-group">
                            <label>Status:</label> 
                            <div class="input-group">                
                                <label class="radio-inline"><input type="radio"   value="deactive" v-model="form.status" checked>Deactive</label>
                                <label class="radio-inline"><input type="radio"   value="active" v-model="form.status" >Active</label>
                                <label class="radio-inline"><input type="radio"   value="suspended" v-model="form.status" >Suspended</label>
                            </div>
                        </div>
                    </div>   
                <div class="col-sm-12 pl-5">
                    <div class="form-group">
                        <label>Description: </label>
                        <textarea v-model="form.description"  placeholder="Place a brief description" class="form-control required"></textarea>
                    </div>
                </div>
                <div class="col-sm-1 pl-5">
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
                 <div class="col-sm-12 horizontal-divider mb-10"></div>
            </form>
        </div>
        <div :class="{hidden:loading}" class="col-md-12">         
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
                                <li><a @click="editPackage(props.row)" class="text-primary" ><i class="icon-pencil3"></i> Edit</a></li>
                                <li><a @click="copyPackage(props.row)" class="text-primary" ><i class="icon-copy3"></i> Copy</a></li>
                                <li><a @click="mirrorPackage(props.row)" class="text-primary" ><i class="icon-mirror"></i> Mirror</a></li>
                                <li><a @click="deletePackage(props.row)" class="text-danger" ><i class="icon-trash-alt"></i> Delete</a></li>
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

export default {
    props: ['sid', 'editMode'],

    data() {
        return {
             loadedPackages: false,
             loadedSection: false,
             pid: this.$route.params.pid,
             form: new Form({
                 id: null,
                 mirror_id: null,
                 section_id: null,
                 name: null,
                 area: null,
                 complexity: null,
                 description: null,        
                 from_date: null,
                 to_date: null,
                 status: 'deactive'
                                                
             }),
             dateFormat:"yyyy-MM-dd",
            //  groups: [],
             section: null,
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
                 
                 sortable: ['id', 'name', 'description', 'area', 'complexity', 'from_date', 'to_date', 'status'],
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

               
             }        
        }
    },
    created() {        
        this.getPackages(this.sid);
        this.getSection(this.sid);
        var _this = this;
        bus.$on('refreshpackages', function(){
            _this.getPackages(_this.sid);
        });

        bus.$on('editpackage', (p)=>{
             for(let property in p){              
                this.form[property] = p[property];
            };
        });       

    },

    computed: {
    
        hasPackages() {
            return (this.packages.length > 0)
        },
        min_date() {
            var today = new Date();
            if(this.section)
            return today > (new Date(this.section.job.from_date))? moment(today).format('YYYY-MM-DD'): this.section.job.from_date;

        },
        max_date() {
            if(this.section)
            return this.section.job.to_date;
        },
        loading: {
            get(){
                return !(this.loadedPackages && this.loadedSection);
            }
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
            this.form.section_id = this.sid;
       
            this.form.post('/api/projects/'+this.pid+'/packages')
                     .then(({data})=>{
                         notice(this.form.notifications, 5000);
                         this.form.reset();
                         this.getPackages(this.sid)})
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);})

        },
        resetForm() {
            this.form.reset();
        },
        getPackages(sid) {
            if(sid)
            axios.get('/api/projects/sections/'+sid+'/packages')
                 .then((data)=>{this.packages = data.data.map(function(e){
                     e.from_date = e.job.from_date;
                     e.to_date =  e.job.to_date;
                     e.status = e.job.status;
                     return e;
                 });
                 this.loadedPackages = true;
            })
        }, 
        getSection(sid) {
             axios.get('/api/projects/sections/'+sid)
                 .then(({data})=>{
                     this.section = data;
                     this.loadedSection = true;
                    })
                 .catch((error)=>{console.log(error)});
        },
     
        
        editPackage(e) {
            for(let property in e){
                this.form[property] = e[property];
            }            

        },
        copyPackage(e) {
            this.editPackage(e);
            this.form.id = null;
        },
        mirrorPackage(e) {
            this.editPackage(e);
            var index = 1;
            this.packages.forEach(function(el) {
                if(el.mirror_id == e.id)
                    index++;
            });
            this.form.mirror_id = this.form.id;
            this.form.id = null;            
            this.form.name += ' - M'+index;
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
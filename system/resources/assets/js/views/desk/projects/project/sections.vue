<template  >

<div class="panel panel-flat">
    <div :class="{loader:loading}" ></div> 
    <div :class="{hidden:loading}"  class="panel-heading">       
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
    <div :class="{hidden:loading}"  class="panel-body">
        <div class="row mb-20" v-if="editMode">
          
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
                            <datepicker 
                                name="from_date" 
                                v-model="form.from_date"
                                :min="min_date"
                                :max="max_date"
                                  ></datepicker>   
                        
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="form-group">
                            <label>To date: <span class="text-danger">*</span></label>
                            <datepicker 
                                name="to_date" 
                                v-model="form.to_date"
                                :min="min_date"
                                :max="max_date"  ></datepicker>   
                        
                        
                        </div>
                    </div>
                    <div class="col-md-6">                    
                        <div class="form-group">
                            <label>Status:</label> 
                                <div class="input-group">                
                                    <label class="radio-inline"><input type="radio"   value="deactive" v-model="form.status" checked>Deactive</label>
                                    <label class="radio-inline"><input type="radio"   value="active" v-model="form.status" >Active</label>
                                    <label class="radio-inline"><input type="radio"   value="suspended" v-model="form.status" >Suspended</label>
                                </div>
                        </div>
                    </div>   
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label>Description:</label>
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
                    <div class="col-sm-12 horizontal-divider"></div>
                </form>           
            
        </div>

        <div >
            <v-client-table
                :data="sections"
                :columns="columns"
                :options="options">

                <template slot="actions" scope="props">            
                    <ul class="icons-list" >
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-menu7"></i>
                            </a>

                            <ul class="dropdown-menu  dropdown-menu-right">
                                <li><router-link class="text-primary" :to="{name:'desk.project.section.packages', params: {sid: props.row.id}}"><i class="icon-cube3"></i> Packages</router-link></li>
                                <li><router-link class="text-primary" :to="{name:'desk.project.section.gwbs', params: {sid: props.row.id}}"><i class="icon-tree5"></i> Swbs</router-link></li>
                                <li><a @click="editSection(props.row)" class="text-primary"  ><i class="icon-pencil3"></i> Edit</a></li>
                                <li><a @click="copySection(props.row)" class="text-primary"  ><i class="icon-copy3"></i> Copy</a></li>
                                <li><a @click="mirrorSection(props.row)" class="text-primary"  ><i class="icon-mirror"></i> Mirror</a></li>
                                <li><a @click="deleteSection(props.row)" class="text-danger" ><i class="icon-trash-alt" ></i> Delete</a></li>
                            </ul>
                        </li>
                    </ul>
                    
                </template>
                        
            </v-client-table>
        </div>
        
    </div>
</div>
     
     

</div>
</template>
<script>


import pwbsg    from './../../../elements/pwbsg';
import gwbs     from './../../../elements/gwbs';
import datepicker     from './../../../elements/Datepicker';

export default {  
    props: ['project_id'],
    data() {
        return {             
             loading: true,        
             group_id: this.$route.params.gid,
             isGrouping: false,
             editMode: sessionStorage.sectionsedit =="true"? true: false,  
             pid: this.$route.params.pid,
             form: new Form({ // New group form
                 id: null,
                 project_id: this.project_id,
                 mirror_id: null,
                 name: null,
                 description: null,             
                 from_date: null,
                 to_date: null,
                 status: null
                                 
             }), 
            
             max_date: '3016-12-28',
             project_from_date: new Date(),


             activeGroup: null,
             sections: [],        
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

               

            },
        }
    },

    created() {        
          
        this.getSections(this.pid); 
        bus.$on('editsection', (section)=>{
             for(let property in section){              
                this.form[property] = section[property];
            };
        })  
       

    },
    computed: {

        min_date: function() {
            var today = new Date();      
            return  today > new Date(this.project_from_date)? moment(today).format('YYYY-MM-DD'): this.project_from_date;
            
        }        
        
    },

    components: {    
           
        datepicker
    },
    methods: {
        editToggle() {
            sessionStorage.sectionedit = this.editMode;
        },
        onSubmit() { 
            this.form.post('/api/projects/'+this.pid+'/sections')
                     .then(({data})=>{                        
                        
                         notice(this.form.notifications, 5000);                                              
                         this.getSections(this.pid);
                         this.form.reset();
                         this.form.project_id = this.project_id;

                         })
                     .catch(({error})=>{
                         notice(this.form.notifications, 5000);
                         })

        },
        getSections(pid) {
            axios.get('/api/projects/'+pid+'/sections')
                 .then(({data})=>{
                      
                     if(data.length > 0) {                          
                          this.sections = data.map(function(e){
                               return {
                                    id: e.id,
                                    project_id: e.project_id,
                                    mirror_id: e.mirror_id,
                                    name:e.name,
                                    description: e.description,                                    
                                    from_date: e.job.from_date,                                
                                    to_date:e.job.to_date,        
                                    status: e.job.status
                               }                             
                        
                        });                     
                      }
                      else
                        this.sections = [];

                    axios.get('/api/projects/'+pid)
                        .then(({data})=>{
                            this.project_from_date = data.job.from_date;
                            this.max_date = data.job.to_date;
                            
                        });
                    this.loading = false; 
                })
        }, 
    
        clearForm() {
            this.form.reset();
        },
        editSection(e) {
            if(!this.editMode)             
                this.editMode = true;

            for(let property in e){              
                this.form[property] = e[property];
            };
        },
        copySection(e) {
            this.editSection(e);
            this.form.id = null;
        },
        mirrorSection(e) {
            this.editSection(e);
            this.form.mirror_id = this.form.id;
            this.form.id = null;
            var index = 1;
            this.sections.forEach(function(el){
            
                if(el.mirror_id == e.id)
                    index++;
            })
            this.form.name += '-M'+index;
           
            
        },  
        
        deleteSection(e) {            
            this.form.id = e.id;         
            var yes = confirm('You are about to delete the group permanently. All users will not be able to use the group.');
            if(yes){  
                if(e.awarded =='awarded') {
                    alert('This group has been awarded as a job and cannot be deleted');
                    return;
                }             
                this.form.post("/api/projects/"+this.form.project_id+"/sections/delete")
                         .then(({data})=>{
                           
                             this.getSections(this.pid); 
                             notice(this.form.notifications, 6000); })
                         .catch((error)=>{ 
                             notice(this.form.notifications, 6000);})               
            }
        },
       

   
    }
}
</script>
<template  >
    <div class="panel panel-flat">
        <div class="panel-heading">            
            <div class="heading-elements">
                  <div class="form-group">             
                    <div class="switch-box">												  
                        <label class="switch ">	
                            <span class="switch-label">Edit</span>																										
                            <input v-model="edit" @click="editMode"type="checkbox" name="edit" >
                            
                            <div class="slider"></div>
                        </label>
                    </div>             
                 </div>
            </div>
        </div>
        
        <div class="panel-body">
            <div v-if="!edit">
                <info
                    v-if="project"
                    :project="project" >
                </info>
            </div>
            <form v-if="edit" @submit.prevent="onSubmit"  @change="form.errors.clear($event.target.name)"   >
                <div class="row"> 
                    <div class="col-md-4 ">
                         <div class="form-group">
                            <label>Project's Name: <span class="text-danger">*</span></label>
                            <input type="text" name="name" v-model="form.name" class="form-control required" placeholder="Project's name" >
                            
                        </div>  
                       												
                    </div> 
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Client: <span class="text-danger">*</span></label>
                            <input v-if="form.id" name="user_id" type="text" :value="form.user.first_name+ ' '+form.user.last_name" disabled class="form-control required"> 
                            <select v-else name="user_id" type="text" v-model="form.user_id" disabled class="form-control required" >
                                <option></option>
                                <option v-for="client in clients" :value="client.id">{{client.first_name}} {{ client.last_name}} </option>
                            </select>                           
                        </div>                                                           
                    </div> 
                    <div class="col-md-4">
                            <div class="form-group">
                            <label>Nation: <span class="text-danger">*</span></label>
                            <select name="nation_abbr" v-model="form.nation_abbr" data-placeholder="Select nation"  class="form-control required">
                                <option></option>                                    
                                <option v-for="nation in nations" :value="nation.abbr">{{nation.name}}</option>                                 
                            </select>
                        </div>                                                
                    </div>                      
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Industry: <span class="text-danger">*</span></label>
                            <select  name="industry_id" type="text" v-model="form.industry_id"  class="form-control required">
                                    <option> </option> 
                                    <option value="1">Residential and commercial buildings</option> 
                                    <option value="2">Industrial and power plant</option> 
                                    <option value="3">Road and bridge</option> 
                                    <option value="4">Small and private home</option> 
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Start date: </label>                 
                            <datepicker name="from_date" v-model="form.job.from_date"  ></datepicker>             
                        </div>
                    </div>	
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>End date: </label>
                            <datepicker name="to_date" v-model="form.job.to_date"  ></datepicker>               
                        </div>
                    </div>								
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Description:</label>                                            
                            <textarea type="text" v-model="form.description"  rows="3" placeholder="Description about the project" value="" class="form-control"></textarea>
                        </div>
                        
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Requirement:</label>
                            <textarea type="text" v-model="form.requirement" rows="3" placeholder="Descriptive job's requirements"  value="" class="form-control"></textarea>
                        </div>
                    </div>										
                </div>
                <div class="row">
                    <div class="col-md-6">                        
                        <div class="form-group">
                            <label>Status:</label> 
                                <div class="input-group">                                    
                                    <label class="radio-inline"><input type="radio"   value="deactive" v-model="form.job.status" checked>Deactive</label>
                                    <label class="radio-inline"><input type="radio"   value="active" v-model="form.job.status" >Active</label>
                                    <label class="radio-inline"><input type="radio"   value="suspended" v-model="form.job.status" >Suspended</label>
                                </div>
                        </div>
                    </div>                                   									
                </div> 
                <div class="row">
                    <div class="col-md-1">
                        <div class="form-group">                                                                     
                            <button type="submit" name="submit" :disabled="form.errors.any()" class="btn btn-primary">Save</button>
                        </div>
                    </div> 
                    <div class="col-md-1">
                        <div class="form-group">                                                                     
                            <button type="button" @click="mirrorProject"  class="btn btn-warning">Mirror</button>
                        </div>
                    </div>                                										
                </div>                   
            </form>
        </div>     
    </div>
</template>

<script>
import info from './../../../elements/project_info';
import datepicker from '././../../../elements/Datepicker';

    export default {
        props: ['project_id'],
        data() {
              
            return {
              edit: (sessionStorage.editProject =="true"? true: false),
              project:  null,
              clients: [],
              nations: [],
             
              form: new Form({
                    id: null,
                    mirror_id: null,
                    name: null,
                    user_id: null,
                    nation_abbr: null,
                    industry_id: null,                
                    description: null,
                    requirement: null,
                    status: 0,                           
          
                    job: {
                        from_date: null,
                        to_date: null,
                        status: null,
                    }
              }),
            }       
        },
        created() {    
            this.getNations();  
            this.getProject(); 
        },       
            
        computed: {
            id: {
                get(){
                    return this.project_id;
                },
                set(newVal) {

                }
            },                    
        },  
        components: {         
            info,
            datepicker                      
        },
        methods: {
            editMode(){      
                sessionStorage.editProject = this.edit;          
            },
            getNations() {
                axios.get('/api/admin/nations')
                    .then((data)=>{this.nations = data.data })
            }, 
            getProject() {
           
                axios.get('/api/projects/'+this.id)
                 .then(({data})=>{                  
                        this.project = data;
                       
                        for(let property  in data){                    
                            this.form[property] = data[property];
                        }                     
                    });
            },
            onSubmit() {
                this.form.post('/api/projects')
                    .then(({data})=>{
                       this.getProject();
                       notice(this.form.notifications, 6000);
                    })
                    .catch(errors => {
                       notice(this.form.notifications, 6000);
                    })
            },
            mirrorProject() {
                this.form.mirror_id = this.form.id;
                this.form.id = null;                
                this.onSubmit();
                
            }
        }
      
    }
</script>

<template  >
<div class="content-wrapper">
    <!-- Page header -->
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

        <div class="panel panel-flat">
            <div class="panel-heading">              
                <div class="heading-elements">
                   
                </div>
            </div>
          
            <div class="panel-body">
                 <form @submit.prevent="onSubmit"  @change="form.errors.clear($event.target.name)"   >
                        <div class="row"> 
                            <div class="col-md-4 ">        

                                <div class="form-group">
                                    <label>Name: <span class="text-danger">*</span></label>
                                    <input type="text" name="name" v-model="form.name" class="form-control required" placeholder="Project's Name" >
                                    
                                </div>   														
                            </div> 
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Client: <span class="text-danger">*</span></label>
                                    <select name="user_id" type="text" v-model="form.user_id" class="form-control required" >
                                        <option></option>
                                        <option v-for="client in clients" :value="client.id">{{client.first_name}} {{ client.last_name}} </option>
                                        
                                    </select>
                                </div>
                                                                    
                            </div>

                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label>Nation: <span class="text-danger">*</span></label>
                                    <select name="nation_id" v-model="form.nation_abbr" data-placeholder="Select nation"  class="form-control required">
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
                                    <select name="industry_id" type="text" v-model="form.industry_id"  class="form-control required">
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
                                    <datepicker name="from_date" 
                                                :min="today"
                                                v-model="form.job.from_date"  ></datepicker>             
                                </div>
                            </div>	
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label>End date: </label>
                                    <datepicker 
                                             :min="today"
                                             name="to_date" v-model="form.job.to_date"  ></datepicker>               
                                </div>
                            </div>								
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Description:</label>                                            
                                    <textarea type="text" v-model="form.description"  rows="5" placeholder="Description about the form" value="" class="form-control"></textarea>
                                </div>
                                
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Requirement:</label>
                                    <textarea type="text" v-model="form.requirement" rows="5" placeholder="Descriptive requirement"  value="" class="form-control"></textarea>
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
                                            <label v-if="form.id" class="radio-inline"><input type="radio"   value="suspended" v-model="form.job.status" >Suspended</label>
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
                                    <button type="button" @click="clear" class="btn btn-default ml-10">Clear</button>
                                </div>
                            </div> 
                                                           										
                        </div>                       
                 </form>
            </div>
        </div>
    </div>
  
    <notify :warns="$store.state.notifications"></notify>
</div>
</template>

<script>   
import notify from './../../../core/Notify';

import datepicker from '././../../elements/Datepicker';
    
  export default {
        data() {
          return {
             
              clients: [],
              nations: [],
              today: moment(new Date()).format('YYYY-MM-DD'),
              form: new Form({
                    id: null,
                    name: null,
                    user_id: null,
                    nation_abbr: null,
                    industry_id: null,                
                    description: null,
                    requirement: null,
                    status: 0,
                    clients: null,     
          
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
        this.getClients();
              
      },      
          
 
      
      components: {
        
          notify,      
          datepicker                 
      },
      methods: {

           onSubmit() {
                this.form.post('/api/projects')
                    .then((data)=>{ 
                        notice(this.form.notifications, 6000);                      
                        this.form.reset();                        
                        
                    })
                    .catch(errors => {
                        notice(this.form.notifications, 6000);                       
                      
                    })
          },

          formNotify() {
                this.$store.commit('loadNotifications', this.form.notifications)
                          
          },

          getNations() {
                axios.get('/api/admin/nations')
                     .then((data)=>{this.nations = data.data })
          }, 

          getClients() {
              axios.get('/api/desk/clients')
                   .then(response => {            
                        this.clients = response.data;}) 
          },
          clear() {
              this.form.reset();
          }
          

    

      }
    
  }
</script>

<style>

.vdp-datepicker input {
    border: 1px solid #ddd;
    border-radius: 2px;
    width: 100%;
    height: 26px;
}

</style>

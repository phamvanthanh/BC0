 <template>
   <div class="panel panel-flat">
        <div class="panel-heading">
            <h6 class="panel-title">List</h6>
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
            <div class="row" >
                <form v-if="editMode" method="post" @submit.prevent="onSubmit" >                                   
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group form-group-sm">
                                <label >First Name:</label>
                                <input v-model="form.from_date"  type="date" placeholder="First name" class="form-control">
                            </div>
                        </div>

                        <div class="col-md-3"> 
                            <div class="form-group form-group-sm">
                                <label >Last Name:</label>
                                <input v-model="form.to_date"   type="date" placeholder="Last name" class="form-control">
                            </div>
                        </div>
                        
                            <div class="col-md-5">
                            <div class="form-group form-group-sm">
                                <label>Status:</label> 
                                <div class="input-group input-sm">
                                    <label class="radio-inline"><input type="radio"   value="active" v-model="form.status" checked>Active</label>
                                    <label class="radio-inline"><input type="radio"   value="deactive" v-model="form.status" >Deactive</label>
                                    <label class="radio-inline"><input type="radio"   value="suspended" v-model="form.status" >Suspended</label>
                                     <label class="radio-inline"><input type="radio"   value="finished" v-model="form.status" >Finished</label>
                                </div>
                            </div>
                        </div>
                            <div class="col-md-1">
                            <div class="form-group form-group-sm">
                                <label class="transparent" >*</label>
                                <button type="submit" class="btn btn-default btn-sm  form-control">Save</button>
                            </div>
                        </div>
                        
                        
                    </div>
                    
                            
                                                    
                        
                </form>

                <table class="table">
                    <thead>
                        <th>
                            Id
                        </th>
                        <th>
                            Name
                        </th>
                        <th>
                            Type
                        </th>
                        <th>
                            Time frame 
                        </th>
                        <th>
                            Bids
                        </th>
                        <th>
                            Status
                        </th>
                        

                    </thead>
                    <tbody>
                        <tr is="job" v-for="job in jobs"
                                :key="job.id"
                                :job="job"
                                :editMode="editMode" >
                        </tr>
                    </tbody>
                    
                </table>
            </div>
        </div>
    </div>        
</template>
<script>

  
import job from './../../elements/jobs/jobrow';
    export default {
        data() {
            return {
                editMode: (localStorage.getItem('jobedit') =="false"? false: true),  
                jobs:[],       
                form: new Form({
                    id: null,                    
                    from_date: null,
                    to_date: null,
                    status: null,                
                    
                }),
                
            }
        },
      
        created() {
            let _this = this;
            this.getJobs();
            bus.$on('editjob', function(e){
                 for(let property in e){
                    _this.form[property] = e[property];
                }
            })
        }, 
        components: { 
            job,                      
        },
        methods: {   
            editToggle() {
                localStorage.setItem('jobedit', this.editMode);
            },      
            getJobs() {
                axios.get('/jobs')
                     .then(({data})=>{
                         this.jobs = data;})
                     .catch((error)=>{
                         console.log(error);})
            },
            onSubmit() {
                this.form.post('/jobs')
                         .then(({data})=>{
                             this.getJobs(); 
                             this.formNotify()})
                         .catch((error)=>{this.formNotify()})
            },
            formNotify() {
                this.$store.commit('loadNotifications', this.form.notifications);            
            },
        }
      
    }
</script>
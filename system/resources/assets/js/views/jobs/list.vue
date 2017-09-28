 <template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <h5><i class="icon-arrow-left52 position-left"></i><span class="text-semibold">Works</span> </h5>
            </div>

            <div class="heading-elements">
               
            </div>
        </div>

    
    </div>
    <!-- /page header -->


    <!-- Content area -->
    <div class="content">

        <div class="panel panel-flat">
            <div class="panel-heading">
           
                <div class="heading-elements">
                    <div class="heading-btn">
                                                    
                    </div>
                </div>
            </div>        
            <div class="panel-body"> 

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
                                    >
                            </tr>
                        </tbody>
                        
                    </table>
                
            </div>
        </div>  
    </div>
</div>
</template>
<script>

  
import job from './workrow';
    export default {
        data() {
            return {
               
                jobs:[],       
               
                
            }
        },
      
        created() {
            let _this = this;
            this.getJobs();
           
        }, 
        components: { 
            job,                      
        },
        methods: {   
  
            getJobs() {
                axios.get('/api/works')
                     .then(({data})=>{
                         this.jobs = data;})
                     .catch((error)=>{
                         console.log(error);})
            },
            
        }
      
    }
</script>
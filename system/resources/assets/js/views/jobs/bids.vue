 <template>
    <div class="panel panel-flat">
    <div class="panel-heading">
     
        <div class="heading-elements">
       
        </div>
    </div>
    
    <div class="panel-body">
        <div class="table-responsive" >
            <table class="table">
                <thead>
                    <th>
                        Id
                    </th>
                    <th>
                        Bidder
                    </th>
                    <th>
                        Bidded on
                    </th>
                    <th>
                        Rate 
                    </th>   
                    <th>
                        A. jobs
                    </th>
                    <th>
                        Status
                    </th>
                </thead>
                <tbody>
                    <tr is="bidrow" v-for="bid in bids"
                            :key="bid.id"
                            :bid="bid" 
                            :awardable="awardable"
                            >
                    </tr>
                </tbody>
                
            </table>
        </div>   
    </div>
</div>
</template>
<script>

  
import bidrow from './../elements/jobs/bidrow';
    export default {
        props: {
            info: null
        },
        data() {
            return {             
               
                bids:[],              
                
            }
        },
      
        created() {   
            this.getBids();
            let awarded = true;           
           
        }, 
        watch: {
            'info.id': function() {
                this.getBids();
            }
        },
        computed: {
            awardable() {
               let awardable = true;
               if(this.bids.length >0) {
                    for(let index in this.bids){                    
                        if(this.bids[index].status == 'awarded'){
                            awardable = false;
                            break;
                        }                                          
                    }                
               }
               return awardable;

            }
        },
        components: { 
            bidrow,                      
        },
        methods: {   
        
            getBids() {
                axios.get('/api/works/'+this.info.id+'/bids')
                     .then(({data})=>{
                         this.bids = data;})
                     .catch((error)=>{
                         console.log(error);})
            },         
          
        }
      
    }
</script>
 <template>
    <div class="panel panel-flat">
        <!--<div :class="{loader:loading}"></div>-->
        <div  class="panel-heading">
            <div class="heading-elements">
                
                </span>
            </div>
        </div>
        
        <div  class="panel-body">
          
             <v-client-table 
                :data="bidData" 
                :columns="columns" 
                :options="options">

                <template slot="isAwarded" scope="props"> 
                        <span :class="[props.row.isAwarded == 'Yes'? 'label-success': 'label-default', 'label' ]">{{props.row.isAwarded}}</span>
                    
                </template>
                <template slot="actions" scope="props">
                     <ul class="icons-list" >
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-menu7"></i>
                            </a>

                            <ul class="dropdown-menu  dropdown-menu-right" >
                                <li class="text-primary-600" > 
                                    <a v-if="props.row.isAwarded  == 'Yes'" @click="withHold(props.row)" class="text-primary" >Withhold</a>                      
                                    <a v-if="props.row.isAwarded == 'No'" @click="award(props.row)" class="text-primary" >Award</a>                       
                                </li>
                                <li>
                                   <a class="text-primary" > User details</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </template>

        
             </v-client-table>
        </div>
    </div>
</template>
<script>
import  ClientTable from 'vue-tables-2';


    export default {
        props: ['info'],
        data() {
            return {
          
            columns: ['id', 'bidder', 'email', 'actives', 'bidon',  'isAwarded',  'actions'],
            options: {
                headings: {
               
                    isAwarded: 'Awrd',
                    bidon: 'Bid Date',
                    actions: ''                 
                },
           
                skin: 'table-hover',
                texts: {
                    filter: ''
                },
                columnsClasses: {
                    id: 'w-70',
                    bidder: 'w-150',
                    email: 'w-200',
                    actives: 'w-70',
                    bidon: 'w-150',
                    isAwarded: 'w-50',
                  
                    actions: 'text-right w-40 action',
                      
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                },


            }         
            }
        },
      
        created() {        
           
        }, 
        computed: {
            awardable() {
               let awardable = true;
               if(this.info.bids.length >0) {
                    for(let index in this.info.bids){                    
                        if(this.info.bids[index].status == 'awarded'){
                            awardable = false;
                            break;
                        }                                          
                    }                
               }
               return awardable;
            },
            bidData() {
                if(this.info.bids)
                    return this.info.bids.map(function(e){
                        return {
                            id: e.id,
                            job_id: e.job_id,
                            user_id: e.user_id,
                            email: e.user.email,
                            bidder: e.user.first_name + ' ' + e.user.last_name,
                            actives: e.user.activeawards.length,
                            bidon: e.created_at,
                            status: e.status,
                            isAwarded: e.status =='awarded'? 'Yes': 'No'

                        }
                    })
                return [];
                
            }
        },
  
        methods: {   
        
            // getBids() {
            //     axios.get('/api/desk/works/'+this.jid+'/bids')
            //          .then(({data})=>{
            //              this.bids = data;
            //              this.loading = false;
            //             })
            //          .catch((error)=>{
            //              console.log(error);})
            // },         
             award(e) {
                var form = new Form(e);
                form.status = 'awarded';
                form.post('/api/desk/works/'+form.id+'/bids')
                         .then(({data})=>{
                             notice(form.notifications, 5000);
                             bus.$emit('bid_success');
                             form.reset()})
                         .catch((error)=>{
                             notice(form.notifications, 5000);
                        })
            },

            withHold(e) {
            
                var form = new Form(e);
                form.status = 'withhold'
                form.post('/api/desk/works/'+form.id+'/bids')
                         .then(({data})=>{
                             notice(form.notifications, 5000);                             
                             bus.$emit('bid_success');
                             form.reset()})
                         .catch((error)=>{
                             notice(form.notifications, 5000);
                          })

            }
        }
      
    }
</script>
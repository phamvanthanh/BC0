 <template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
               <window-heading2></window-heading2>                   
            </div>

            <div class="heading-elements">
               
            </div>
        </div>

    
    </div>
    <!-- /page header -->


    <!-- Content area -->
    <div class="content">
         <div :class="{loader:loading}"></div>
        <div :class="{hidden:loading}" class="panel panel-flat">
            <div class="panel-heading">
           
                <div class="heading-elements">
                    <div class="heading-btn">
                                                    
                    </div>
                </div>
            </div>        
            <div class="panel-body"> 
                <div v-if="jobs.length >0">
                    <v-client-table
                        :data="jobs"
                        :columns="columns"
                        :options="options">
                        <template slot="actions" scope="props" >
                            <ul class="icons-list">
                                <li>
                                    <router-link :to="{name: 'job', params: {id: props.row.id}}"><i class="icon-unfold"></i></router-link>
                                </li>
                            </ul>

                        </template>
                        <template slot="num_bids" scope="props">  
                            <span :class="[props.row.num_bids > 0? 'label-primary': 'label-default', 'label' ]">{{props.row.num_bids}}</span>
                        </template>

                    
                    </v-client-table>    
                </div>
                <div v-else>
                    <div class="table-norecord">
                        <span>No records.</span>
                    </div>       
                </div>
            </div>
        </div>  
    </div>
</div>
</template>
<script>

import  ClientTable from 'vue-tables-2';
import {capitalize} from './../../core/filters';

    export default {
        data() {
            return {
                loading: true,
                jobs:[],
                columns: ['id', 'name', 'jobable_type', 'project', 'nation',  'from_date', 'to_date', 'num_bids', 'actions'],
                options: {
                    headings: {
                        id: 'Id',
                        name: 'Name',
                        jobable_type: 'Type',
                        project: 'Project',
                        from_date: 'From',
                        to_date: 'To',
                        num_bids: 'Bids',
                        status: 'status',
                        actions: ''
                    },
              
                    skin: 'table-hover',
                    texts: {
                        filter: ''
                    },
                    columnsClasses: {
                        id: 'w-70',
                        name: 'column-expanded',
                        jobable_type: 'w-70',
                        project: 'w-200',
                        nation: 'w-70',
                        from_date: 'w-80',
                        to_date: 'w-80',                       
                        num_bids: 'w-70', 
                        actions: 'text-right w-40 action' 
                    },
                    sortIcon: { 
                        base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                    },
                    perPage: 25,
                    perPageValues: [10,25,50,100],
                }                
            }
        },
      
        created() {
            let _this = this;
            this.getJobs();
           
        }, 
        methods: {   
  
            getJobs() {
                axios.get('/api/works')
                     .then(({data})=>{
                         this.jobs = data.map(function(e){
                            
                             return {
                                 id: e.id,
                                 name: e.info.jobable.name,
                                 jobable_type: capitalize(e.jobable_type),
                                 project: e.info.project.name,
                                 nation: e.info.project.nation.abbreviation,
                                 from_date: moment(e.from_date).format('YY/MM/DD'),
                                 to_date: moment(e.to_date).format('YY/MM/DD'),
                                 num_bids: e.info.bids? e.info.bids.length: 0
                             };
                             
                         });
                         this.loading = false;
                        })
                     .catch((error)=>{
                         console.log(error);})
            },
    
        }
      
    }
</script>
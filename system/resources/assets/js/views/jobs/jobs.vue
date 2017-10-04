 <template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                                
            </div>

            <div class="heading-elements">
               
            </div>
        </div>

    
    </div>
    <!-- /page header -->


    <!-- Content area -->
    <div class="content">
        
        <div  class="panel panel-flat">
            <div class="panel-heading">
           
                <div class="heading-elements">
                    <div class="heading-btn">
                                                    
                    </div>
                </div>
            </div>        
            <div class="panel-body"> 
                <div class="row" >
                    <v-server-table
                        url="/api/works"
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

                    
                    </v-server-table>    
                </div>
     
            </div>
        </div>  
    </div>
</div>
</template>
<script>


import {capitalize} from './../../core/filters';

    export default {
        data() {
            return {
            
                jobs:[],
                columns: ['id', 'name', 'jobable_type', 'project', 'nation_abbr',  'from_date', 'to_date', 'bid_count', 'actions'],
                options: {
                    headings: {
                        id: 'Id',
                        name: 'Name',
                        jobable_type: 'Type',
                        project: 'Project',
                        nation_abbr: 'Nation',
                        from_date: 'From',
                        to_date: 'To',
                        bid_count: 'Bids',
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
                        nation_abbr: 'w-70',
                        from_date: 'w-80',
                        to_date: 'w-80',                       
                        bid_count: 'w-70', 
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
      
     
      
    }
</script>
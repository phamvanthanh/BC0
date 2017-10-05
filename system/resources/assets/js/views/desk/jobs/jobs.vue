<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>
            </div>

            <div class="heading-elements">
               
            </div>
        </div>    
    </div>

    <div class="content">
    
        <div  class="panel panel-flat">
            <div class="panel-heading">
           
                <div class="heading-elements">
                    <div class="heading-btn">
                                                    
                    </div>
                </div>
            </div>        
            <div class="panel-body"> 
                <div >
                    <v-server-table 
                        ref="job_table"
                        url="/api/desk/works"                                             
                        :columns="columns" 
                        :options="options"
                    >
                         <template slot="jobable_type" scope="props">
                             {{props.row.jobable_type | capital}}
                           
                        </template>
                        <template slot="actions" scope="props">
                           
                                <router-link :to="{name: 'desk.job', params: {id: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                           
                        </template>
                        <template slot="bid_status" scope="props">  
                            <span :class="[props.row.bid_status == 'awarded'? 'label-success': 'label-default', 'label' ]">{{props.row.bid_status | capital}}</span>
                        
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

export default {
    data() {
        return {

          
            columns: ['id', 'name', 'jobable_type', 'project', 'nation_abbr', 'from_date', 'to_date', 'bid_count', 'bid_status', 'status', 'actions'],
            options: {
                headings: {
                    id: 'Id',
                    name: 'Name',
                    jobable_type: 'Type',
                    project: 'Project',
                    from_date: 'From',
                    to_date: 'To',  
                    nation_abbr: 'Nation',
                    bid_count: 'Bids',
                    bid_status: 'Awrd',
                    
                    actions: ''
                    
                },
                templates: {        
                    status: 'status'                    
                },
                dateFormat: "DD/MM/YY",
                dateColumns: ['from_date', 'to_date'],
                columnsClasses: {
                    id: 'w-70',
                    name: 'column-expanded',
                    jobable_type: 'w-70',
                    project: 'w-150',
                    nation_abbr: 'w-70',
                    from_date: 'w-80',
                    to_date: 'w-80',
                    bid_count: 'w-50',
                    bid_status: 'w-100',
                    progress: 'w-150',
                    status: 'w-70', 
                    actions: 'text-right w-40 action',
                      
                },
                sortable:['id', 'name', 'jobable_type', 'project', 'from_date', 'to_date', 'bid_status', 'status'],
                perPage: 25,        

            }        
            
        }
    },
    filters: {
        capital(value) {
            return capitalize(value);
        }
    }
    

}
</script>
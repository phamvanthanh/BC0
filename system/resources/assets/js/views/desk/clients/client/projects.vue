<template>
  
<div class="panel panel-flat">
    <div class="panel-heading">

        <div class="heading-elements">
            <div class="heading-btn">
                                            
            </div>
        </div>
    </div>        
    <div class="panel-body">                   
        
        <v-client-table 
            :data="tableData" 
            :columns="columns" 
            :options="options">
            <template slot="actions" scope="props">
                <ul class="icons-list" >
                    <li>
                            <router-link :to="{name: 'desk.project.info',params: {pid: props.row.id}}"><i class="icon-unfold"></i></router-link>
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
        props:['client'],
        data() {
            return {               
                columns: ['job_id', 'name', 'nation', 'industry', 'from_date', 'to_date', 'status', 'actions'],              
                options: {
                 headings: {
                    job_id: 'Id',
                    nation_name: 'Nation',                    
                    industry: 'Ind.',
                    from_date: 'From',
                    to_date: 'To',
                    status: 'status',
                    actions: ''                       
                  
                },
                
                templates: {                   
                    status: 'status',
                },            

                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                },     

                skin: 'table-hover',
                texts: {
                    filter: 'Filter: '
                },
                columnsClasses: {
                    job_id: 'w-70',
                    name: 'w-150',
                    nation: 'w-70',
                    industry: 'w-70',                                
                    from_date: 'w-80',
                    to_date: 'w-80',              
                    status: 'w-70',
                    actions: 'text-right w-40 action' 
                }         
           
            }               
                
            }
        },
      


        computed: {
            tableData: function() {
                if(this.client)
                if(this.client.projects)
                    return this.client.projects.map(function(e){
                        return {
                            id: e.id,
                            job_id: e.job.id,
                            name: e.name,
                            nation: e.nation.abbreviation,
                            industry: e.industry.name,
                            from_date: e.job.from_date,
                            to_date: e.job.to_date,
                            status: e.job.status
                        };
                    });
                return [];
            }
        },
   
   
      
    }
</script>
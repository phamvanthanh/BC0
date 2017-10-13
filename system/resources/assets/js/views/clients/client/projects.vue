<template  >
<div class="content-wrapper">
   
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">          
            <div class="page-title">
                <page-label></page-label>              
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                       <router-link to="/clients/projects/new" class="btn btn-link btn-float has-text"><i class="icon-pencil7"></i><span>New</span></router-link>
                   
                </div>
            </div>
        </div>   
    </div>
 
    <div class="content">
        
        <div  class="panel panel-flat">
            <div class="panel-heading">
          
                <div class="heading-elements">
                    <ul class="icons-list">
                 
                    </ul>
                </div>
            </div>
          
            <div class="panel-body">
                <div v-if="projects.length>0">
                    <v-client-table 
                        :data="projects" 
                        :columns="columns" 
                        :options="options">

                        <template slot="actions" scope="props">
                            <router-link class="text-primary" :to="{name:'client.project.info', params: {pid: props.row.id}}">   <i class="icon-unfold"></i></router-link>
                           
                            </ul>
                        
                        </template>
                    </v-client-table>
                </div>
                <div v-else>
                    
                </div>
            </div>        
        </div>
    </div>
    <notify :warns="$store.state.notifications"></notify>
</div>
</template>

<script>
import notify from './../../../core/Notify';


 
export default {
    data() {
      return {
           
            projects: [],
            columns: ['job_id', 'name',  'nation_abbr', 'industry', 'from', 'to', 'created', 'status', 'actions'],              
            options: {
                 headings: {
                    job_id: 'Id',              
                    nation_abbr: 'Nation',
                    industry: 'Industry',
                    from: 'From',
                    to: 'To',
                    created: 'Created',
                    status: 'Status',   
                    actions: ''            
                  
                },

                templates: {
                  
                    status: 'status'
                },
           
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                },   

                skin: 'table-striped table-hover',
                texts: {
                    filter: ''
                },
                columnsClasses: {
                   
                    job_id: 'w-70',
                    name: 'column-expanded',                   
                    nation: 'w-70',
                    industry: 'w-70',
                    from: 'w-80',
                    to: 'w-80',
                    created: 'w-80',
                    progress: 'w-150',
                    status: 'w-70', 
                    actions: 'text-right w-30 action'           

                }
         
         
           
            }
        }
    },

    created() {

        this.getProjects();
    },
    components: { 
        notify                    
    },
    methods: {
        getProjects() {
            axios.get('/api/clients/projects')
                .then(({data})=> {
        
                this.projects = data.map(function(e){
                    return {
                        id: e.id,
                        job_id: e.job.id,
                        name: e.name,
                        nation_abbr: e.nation_abbr,                   
                        industry: e.industry.name,
                        from: moment(e.job.from_date).format('YY/MM/DD'),
                        to: moment(e.job.to_date).format('YY/MM/DD'),
                        created: moment(e.created_at).format('YY/MM/DD'),
                        status: e.job.status
                        };
                    });

                this.loading = false;                   
            });
        },

    }      
}
</script>



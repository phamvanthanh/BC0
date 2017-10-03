<template>

<div class="content-wrapper">
  
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
              <window-heading2></window-heading2>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                   
                </div>
            </div>
        </div>    
    </div>

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
                <div v-if="awards.length>0">
            
                    <v-client-table
                            :data="awards"
                            :columns="columns"
                            :options="options">

                            <template slot="actions" scope="props">
                                <router-link :to="{name: 'myjob.info', params: {id: props.row.id}}" ><i class="icon-unfold"></i></router-link>
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
import  {ClientTable} from 'vue-tables-2';
Vue.use(ClientTable);

export default {
    
    props: ['user', 'info'],

    data() {
        return {
            loading: true,
            awards: [],
            columns: ['id', 'name', 'jobable_type', 'project', 'nation_abbr', 'from_date', 'to_date', 'status', 'actions'],
                options: {
                    headings: {
                        id: 'Id',
                        name: 'Name',
                        jobable_type: 'Type',
                        project: 'Project',
                        nation_abbr: 'Nation', 
                        from_date: 'From',
                        to_date: 'To',
                        num_bids: 'Bids',
                        actions: ''
                    },
                    templates: {                      
                        status: 'status'
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
                        status: 'w-70', 
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
    filters: {
        capital(value) {
            return capitalize(value);
        }
    },
    created() {
        this.getWorks();
    },
    methods: {
       
        getWorks() {
            axios.get('/api/jobs')
                 .then(({data})=>{
            
                     this.awards = data.map(function(e){
                         
                         return {
                            id: e.job_id,
                            name: e.info.jobable.name,
                            jobable_type: capitalize(e.info.jobable_type),
                            project: e.info.project.name,
                            nation: e.info.project.nation.abbreviation,
                            from_date: moment(e.info.from_date).format('YY/MM/DD'),
                            to_date: moment(e.info.to_date).format('YY/MM/DD'),
                            status: e.info.status

                         }; 

                     });
                     this.loading = false;
                    
                 })
                 .catch((error)=>console.log(error))
        },    
    
    }
}
    

</script>
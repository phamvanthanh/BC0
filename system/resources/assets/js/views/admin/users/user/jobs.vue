<template>
     
    <div class="sub-panel panel-flat">
        <div class="panel-heading">
           
            <div class="heading-elements">
                <div class="heading-btn">
                    
                </div>
            </div>
        </div>
        
        <div class="panel-body">
            <div class="col-md-12">
                <v-client-table
                    :data="jobs"
                    :columns="columns"
                    :options="options">
                    <template slot="actions" scope="props">
                        <router-link :to="{name: 'jobInfo', params: {id: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                    </template>
                </v-client-table>
            </div>
        </div>
        
        
        
    </div>

</template>
<script>
import  ClientTable from 'vue-tables-2';

export default {
    
    props: ['uid'],
    data() {
        return {
            jobs: [],
            columns: ['id', 'name', 'jobable_type', 'project', 'nation', 'bid_status', 'status'],
                options: {
                    headings: {
                        id: 'Id',
                        name: 'Name',
                        jobable_type: 'Type',
                        project: 'Project',
                        bid_status: 'Bid Stat.',
                        job_status: 'Job Stat.',
                        num_bids: 'Bids'
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
                        jobable_type: 'w-150',
                        project: 'w-150',
                        nation: 'w-80',
                        bid_status: 'w-100',
                        status: 'w-80'
                    },
                    sortIcon: { 
                        base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                    },
                }      
        }
    },
    created() {
        this.getUserJobs(this.uid);
    },
    watch: {
        uid: function(val) {
            this.getUserJobs(val);
        }
    },
    methods: {
      
        getUserJobs(uid) {
            if(uid)
            axios.get('/api/admin/users/'+uid+'/jobs')
                 .then(({data})=>{
                     this.jobs = data.map(function(e){
                         return {
                             id: e.job_id,
                             name: e.job.info.jobable.name,
                             project:  e.job.info.project.name,
                             nation: e.job.info.project.nation.abbreviation,
                             jobable_type: e.job.info.jobable_type,
                             bid_status: e.status,
                             status: e.job.status


                         }
                     })
                    })
                 .catch((error)=>console.log(error))
        },      
    
    }
}
    

</script>


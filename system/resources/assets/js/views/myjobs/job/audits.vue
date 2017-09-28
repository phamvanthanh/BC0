<template>
<div class="panel panel-flat">
    <div class="panel-heading">
        <h6 class="panel-title">Jobs</h6>
        <div class="heading-elements">
        
        </div>
    </div>
    
    <div class="panel-body">        
          <v-client-table
                :data="packages"
                :columns="columns"
                :options="options">
                <template slot="actions" scope="props">
                    <router-link :to="{name: 'myjob.audit', params: {sid: props.row.id}}" ><i class="icon-unfold"></i></router-link>
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
            packages: [],
            columns: ['id', 'name', 'description', 'quantum', 'assign_date', 'actions'],
            options: {
                  headings: {
                        // id: 'Id',
                        // name: 'Name',
                        // jobable_type: 'Type',
                        // project: 'Project',
                        // from_date: 'From',
                        // to_date: 'To',
                        // num_bids: 'Bids',
                        responder: 'Rpdr',
                        actions: ''
                    },
              
                    skin: 'table-hover',
                    texts: {
                        filter: 'Filter: '
                    },
                    columnsClasses: {
                        id: 'w-70',
                        name: 'w-150',
                        description: 'column-expanded',
                        quantum: 'w-100',                    
                        assign_date: 'w-150',
                        completed: 'w-150',
                        actions: 'text-right w-40 action' 
                       
                    },
                    sortIcon: { 
                        base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                    },

            }
    }
    },
  
    created() {
        this.getPackages();
    },
    watch: {
        'info.id': function() {
            this.getPackages();
        }
    },
    methods: {
        getPackages() {
            if(this.info.jobable_type == 'group') {
                axios.get('/api/projects/groups/'+this.info.jobable_id+'/packages')
                     .then(({data})=>this.packages = data.map(function(e){
                         return {
                             id: e.job.id,
                             name: e.name,
                             description: e.description,
                             quantum: e.quantum,                            
                             assign_date: e.job.awarded? e.job.awarded.created_at: 'Pending asign',
                             completed: 100*(e.cmtd_quantum/e.quantum).toFixed(2)
                         }
                     }))
                     .catch((error)=>console.log(error));
            }
        }
    }
}
</script>



<!--Project list -->
<template>
    

          <v-client-table :data="projects" :columns="columns" :options="options"></v-client-table>


</template>
<script>

import {ServerTable, ClientTable, Event} from 'vue-tables-2';
// Vue.use(ClientTable, [options], [useVuex], [customTemplate]);

Vue.use(ClientTable);

    export default {

        data() {
            return {
                projects: [],
                columns: ['id','name', 'client', 'industry', 'nation', 'from', 'to', 'created', 'status' ],              
                options: {
                    perPage: 15,
                    perPageValues: [10,15,20,20,25,30]
                }, 
            
            }     
           
       
        },
   
        created(){
            axios.get('/projects')
                 .then(({data})=> {
                     this.projects = data.map(function(e){
                        return {
                            id: e.id,
                            name: e.name,
                            client: e.user.first_name + ' ' + e.user.last_name,
                            nation: e.nation.name,
                            industry: e.industry.name,
                            from: e.job.from_date,
                            to: e.job.to_date,
                            created: moment(e.created_at).fromNow(),
                            status: e.job.status
                        };
                    });
                 });
        },

        
    }
</script>
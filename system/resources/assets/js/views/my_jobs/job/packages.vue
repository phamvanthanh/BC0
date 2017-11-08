<template>
<div class="panel panel-flat">
    <div class="panel-heading">     
        <div class="heading-elements">
        
        </div>
    </div>
    
    <div class="panel-body">        
         <v-client-table
                :data="packages"
                :columns="columns"
                :options="options">
                <template slot="rate" scope="props" >
                    <span @click="openRate(props.row)" ><Rate :length="5" :value="props.row.rate"></Rate></span>
                </template>
                <template slot="actions" scope="props">
                    <router-link :to="{name: 'my_job.package', params: {sid: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                </template>
        </v-client-table> 
        <modal v-if="showModal"
                :data="modalData">
        </modal>
    </div>
    
</div>

</template>
<script>

import  ClientTable from 'vue-tables-2';
import Rate from './../../elements/ratedisplay';
import modal from './modals/rateJobModal';

export default {
    props: ['info'],
    components: {
        Rate,
        modal
    },
    data() {
        return {
            showModal: false,
            packages: [],
            columns: ['id', 'name', 'description', 'quantum', 'assign_date', 'rate', 'actions'],
            options: {
                  headings: {                
                        actions: ''
                    },

                    columnsClasses: {
                        id: 'w-70',
                        name: 'w-150',
                        description: 'column-expanded',
                        quantum: 'w-100',                    
                        assign_date: 'w-150',
                        completed: 'w-150',
                        rate: 'w-100',
                        actions: 'text-right w-40 action' 
                       
                    },
                 
            }
        }
    },

  
    created() {
        this.getPackages();
        let _this = this;
        this.$on('closemodal', function(){
            _this.showModal = false;
        });
        this.$on('refreshparent', function(){
            _this.getPackages();
        })
    },
    watch: {
        'info.id': function() {
            this.getPackages();
        }
    },
    methods: {
        getPackages() {
            if(this.info.jobable_type == 'section') {
                axios.get('/api/projects/sections/'+this.info.jobable_id+'/packages')
                     .then(({data})=>this.packages = data.map(function(e){
                         return {
                             id: e.job.id,
                             name: e.name,
                             description: e.description,
                             quantum: e.quantum,                            
                             assign_date: e.job.awarded? e.job.awarded.created_at: 'Pending award',
                             rate: e.job.rate,
                             comment: e.job.comment,
                             status: e.job.status
                         }
                     }))
                     .catch((error)=>console.log(error));
            }
        },
        openRate(e) {
            this.modalData = {job_id:e.id, rate: e.rate, comment: e.comment};
            this.showModal= true;

        }
    }
}
</script>



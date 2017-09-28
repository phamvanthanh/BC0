<template>
<div class="panel panel-flat">
    <div :class="{loader:loading}"></div>
    <div  :class="{hidden:loading}" class="panel-heading">
        <div class="heading-elements">
        
        </div>
    </div>
    
    <div :class="{hidden:loading}" class="panel-body">        
          <v-client-table
                :data="sections"
                :columns="columns"
                :options="options">
                <template slot="rate" scope="props" >
                    <span @click="openRate(props.row)" ><Rate :length="5" :value="props.row.rate"></Rate></span>
                </template>
                <template slot="actions" scope="props">
                    <router-link :to="{name: 'myjob.section', params: {jid1: props.row.job_id}}" ><i class="icon-unfold"></i></router-link>
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
        modal,
        Rate
    },
    data() {
        return {
            loading: true,
            showModal: false,
            modalData: null,
            sections: [],
            columns: ['job_id', 'name', 'description', 'from_date', 'to_date', 'assign_date', 'rate', 'actions'],
            options: {
                  headings: {
                         job_id: 'Id',
                         assign_date: 'Asigned',                       
                         actions: ''
                    },
              
                    skin: 'table-hover',
                    texts: {
                        filter: 'Filter: '
                    },
                    columnsClasses: {
                        job_id: 'w-70',
                        name: 'w-150',
                        description: 'column-expanded', 
                        from_date: 'w-100',
                        to_date: 'w-100',                                        
                        assign_date: 'w-150',
                        rate: 'w-100',
                        actions: 'text-right w-40 action' 
                       
                    },
                    sortIcon: { 
                        base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                    },

            }
    }
    },
  
    created() {
        let _this = this;
        this.getSections(this.info.jobable_id);
        this.$on('closemodal', function(){
            _this.showModal = false;
        });
        this.$on('refreshparent', function(){
            _this.getSections(_this.info.jobable_id);
        })
    },
    watch: {
        'info.id': function() {
            this.getSections(this.info.jobable_id);
        }
    },
    methods: {
        getSections(pid) {
            if(this.info.jobable_type == 'project') {
             
            axios.get('/api/projects/'+pid+'/sections')
                 .then(({data})=>{
                      
                     if(data.length > 0) {
                          
                          this.sections = data.map(function(e){
                               return {
                                    id: e.id,
                                    job_id: e.job.id,
                                    name:e.name,
                                    description: e.description,                                    
                                    from_date: e.job.from_date,                                
                                    to_date:e.job.to_date, 
                                    assign_date:  e.job.awarded? moment(e.job.awarded.created_at).format('YYYY-MM-DD hh:mm'): 'N/A',      
                                    status: e.job.status,
                                    rate: e.job.rate,
                                    comment: e.job.comment
                               }  
            
                        
                        });                        
                 
                      }
                      else
                        this.sections = [];

                      this.loading = false;
                })
         
            }
        },
        openRate(e) {
            this.modalData = e;
            this.showModal= true;

        }
    }
}
</script>



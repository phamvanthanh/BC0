<template  >
<div class="content-wrapper">
   
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">          
            <div class="page-title">
                <window-heading2></window-heading2> 
           
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                       <router-link to="/desk/projects/new" class="btn btn-link btn-float has-text"><i class="icon-pencil3"></i><span>New</span></router-link> 
                   
                </div>
            </div>
        </div>   
    </div>
 
    <div class="content">
        <div :class="{loader:loading}"></div>   
        <div :class="{hidden:loading}" class="panel panel-flat">
            <div class="panel-heading">              
                <div class="heading-elements">
                    <ul class="icons-list">
                          
                    </ul>
                </div>
            </div>
          
            <div class="panel-body">
                <div v-if="tableData.length > 0">
                    <v-client-table 
                        :data="tableData" 
                        :columns="columns" 
                        :options="options">
                        <template slot="rate" scope="props" >
                            <span @click="openRate(props.row)" ><Rate :length="5" :value="props.row.rate"></Rate></span>
                        </template>
                        <template slot="actions" scope="props">
                            <div>
                                <router-link :to="{name: 'desk.project.info', params: {pid: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                            </div>
                        </template>
                    </v-client-table>
                    <modal v-if="showModal"
                        :data="modalData">
                    </modal>
                </div>
                <div v-else>
                    <div class="no-record">
                        <span>No records.</span>
                    </div>
                </div>
            </div>        
        </div>
        <notify :warns="$store.state.notifications"></notify>
        
    </div>
</div>
</template>

<script>

import ClientTable from 'vue-tables-2';
import Rate from './../../elements/ratedisplay';
import modal from './../../elements/rateJobModal';
import notify from './../../../core/Notify';


export default {
    components: {
        Rate,
        modal,
        notify
    },
    data() {
      return {
            loading: true,
            showModal: false,
            tableData: [],
            columns: ['job_id', 'name', 'client', 'nation', 'industry', 'from', 'to', 'status', 'rate', 'actions'],              
            options: {
                 headings: {
                    job_id: 'Id',                                      
                    client: 'Client',
                    nation: 'Ntn.',
                    industry: 'Ind.',
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

                skin: 'table-hover',
                texts: {
                    filter: ''
                },
                columnsClasses: {
                   
                    job_id: 'w-70',
                    name: 'column-expanded',
                    client: 'w-150',
                    nation: 'w-70',
                    industry: 'w-70',
                    from: 'w-80',
                    to: 'w-80',
                    rate: 'w-100',
                    status: 'w-70', 
                    actions: 'text-right w-40 action'           

                }
         
           
            }
        }
    },

    created() {
        let _this = this;
        this.getProjects();
        this.$on('closemodal', function(){
            _this.showModal = false;
        });
        this.$on('refreshparent', function(){
            _this.getProjects();
        })
    },

    methods: {
    
        getProjects() {
            axios.get('/api/projects')
                .then(({data})=> {
            this.tableData = data.map(function(e){
                return {
                    id: e.id,
                    job_id: e.job.id,
                    name: e.name,
                    client: e.user.first_name + ' ' + e.user.last_name,
                    nation: e.nation.abbreviation,
                    industry: e.industry.name,
                    from: e.job.from_date,
                    to: e.job.to_date,               
                    created: moment(e.created_at).fromNow(),
                    status: e.job.status,
                    rate:e.job.rate,
                    comment: e.job.comment
                    };
                });
            this.loading = false;
                   
            });
        },
        openRate(e) {
            this.modalData = e;
            this.showModal= true;

        }

    }      
}
</script>



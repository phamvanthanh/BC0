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
      
        <div class="panel panel-flat">
            <div class="panel-heading">              
                <div class="heading-elements">
                    <ul class="icons-list">
                          
                    </ul>
                </div>
            </div>
          
            <div class="panel-body">
                <div >
                    <v-server-table 
                        ref="project_table"
                        url="/api/projects" 
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
                    </v-server-table>
                    <modal v-if="showModal"
                        :data="modalData">
                    </modal>
                </div>
              
            </div>        
        </div>
        <notify :warns="$store.state.notifications"></notify>
        
    </div>
</div>
</template>

<script>


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
            
            showModal: false,
            tableData: [],
            columns: ['id', 'name', 'client', 'nation_abbr', 'industry', 'from_date', 'to_date', 'status', 'rate', 'actions'],              
            options: {
                 headings: {
                    id: 'Id',                                      
                    client: 'Client',
                    nation_abbr: 'Ntn.',
                    industry: 'Ind.',
                    from_date: 'From',
                    to_date: 'To',
                    created: 'Created',
                    status: 'Status',  
                    actions: ''             
                  
                },
                
                templates: {      
                    status: 'status'
                },

                sortable: ['id', 'name', 'client', 'nation_abbr', 'industry', 'from_date', 'to_date', 'status', 'rate'],

                columnsClasses: {
                   
                    id: 'w-70',
                    name: 'column-expanded',
                    client: 'w-150',
                    nation_abbr: 'w-70',
                    industry: 'w-70',
                    from_date: 'w-80',
                    to_date: 'w-80',
                    rate: 'w-100',
                    status: 'w-70', 
                    actions: 'text-right w-40 action'           

                }
         
           
            }
        }
    },

    created() {
        let _this = this;
      
        this.$on('closemodal', function(){
            _this.showModal = false;
        });
      
    },

    methods: {
    
     
        openRate(e) {
            this.modalData = e;
            this.showModal= true;

        }

    }      
}
</script>



<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <window-heading2></window-heading2>   
            </div>

            <div class="heading-elements">
               
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
                <v-client-table 
                    :data="leads" 
                    :columns="columns" 
                    :options="options">
                    <template slot="actions" scope="props">
                        <div>
                            <router-link :to="{name: 'desk.job', params: {id: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                        </div>
                    </template>
                    <template slot="isAwarded" scope="props">  
                          <span :class="[props.row.isAwarded == 'Yes'? 'label-success': 'label-default', 'label' ]">{{props.row.isAwarded}}</span>
                       
                    </template>
                    <template slot="num_bids" scope="props">  
                           <span :class="[props.row.num_bids > 0? 'label-primary': 'label-default', 'label' ]">{{props.row.num_bids}}</span>
                    </template>
                </v-client-table>
                
            </div>
        </div>  
    </div>
</div>
</template>
<script>

import  ClientTable from 'vue-tables-2';
import {capitalize} from './../../../core/filters';


export default {
    data() {
        return {
            loading: false,
            leads:[],
            columns: ['id', 'first_name', 'last_name', 'email',  'phone', 'company', 'subscription','actions'],
            options: {
                headings: {
                    id: 'Id',
                    first_name: 'First Name',
                    last_name: 'Last Name',                   
                    subscription: 'Sub',                   
                    actions: ''
                    
                },
           
                skin: 'table-hover',
                texts: {
                    filter: ''
                },
                columnsClasses: {
                    id: 'w-70',
                    email: 'column-expanded',
                    first_name: 'w-150',
                    last_name: 'w-150',
                    from_date: 'w-80',
                    phone: 'w-150',
                    company: 'w-200',
                    subscription: 'w-50',
                    progress: 'w-150',
                    
                    actions: 'text-right w-40 action',
                      
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                },
                perPage: 25,
                perPageValues: [10,25,50,100],


            }          
            
            
        }
    },
    
    created() {
        this.getLeads();
        
    }, 

    methods: {   

        getLeads() {
            axios.get('/api/desk/leads')
                    .then(({data})=>{
                        this.leads = data;
                        this.loading = false;
                    })
                    .catch((error)=>{
                        console.log(error);})
        },        
    }
    
}
</script>
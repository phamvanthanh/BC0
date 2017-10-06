<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                 <page-label></page-label>
            </div>

            <div class="heading-elements">
               
            </div>
        </div>

    
    </div>

    <div class="content">
           
        <div  class="panel panel-flat">
            <div class="panel-heading">
           
                <div class="heading-elements">
                    <div class="heading-btn">
                                                    
                    </div>
                </div>
            </div>        
            <div class="panel-body"> 
                <v-server-table 
                    url="/api/desk/leads" 
                    :columns="columns" 
                    :options="options">
                    <template slot="name" scope="props">
                        {{props.row.first_name}} {{props.row.last_name}}
                    </template>
                    <template slot="actions" scope="props">
                        <!--<div>
                            <router-link :to="{name: 'desk.job', params: {id: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                        </div>-->
                    </template>
                   
                </v-server-table>
                
            </div>
        </div>  
    </div>
</div>
</template>
<script>

import {capitalize} from './../../../core/filters';


export default {
    data() {
        return {
          
            columns: ['id', 'name', 'email',  'phone',  'sub', 'message', 'created_at', 'actions'],
            options: {
                headings: {
                    id: 'Id',
                    created_at: 'Sub. Time',                   
                    sub: 'Sub',                   
                    actions: ''
                    
                },
         
                columnsClasses: {
                    id: 'w-70',
                    email: 'w-200',
                    message: 'column-expanded',
                    name: 'w-150',                  
                    phone: 'w-150',                 
                    sub: 'w-70',
                    created_at: 'w-150',                   
                    actions: 'text-right w-40 action',
                      
                },
                sortable: ['id', 'name', 'email', 'phone', 'message', 'sub', 'created_at'],
                perPage: 25,
               


            }          
            
            
        }
    },
    
 

   
    
}
</script>
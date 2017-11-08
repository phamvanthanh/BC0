<template>

<div class="content-wrapper">  
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                   
                </div>
            </div>
        </div>    
    </div>

    <div class="content">
       
        <div class="panel panel-flat">
            <div class="panel-heading">             
                <div class="heading-elements">
                    <div class="heading-btn">
                      
                    </div>
                </div>
            </div>
          
            <div class="panel-body">
                <div class="row" >
            
                    <v-server-table
                            url="/api/bids"
                            :columns="columns"
                            :options="options">
                            <template slot="jobable_type" scope="props">
                                {{props.row.jobable_type | capital}}
                            </template>
                            <template slot="actions" scope="props">
                                <router-link :to="{name: 'job', params: {id: props.row.id}}" class="text-primary" ><i class="icon-unfold"></i></router-link>
                            </template>
                    </v-server-table>     
                </div>
               
            </div>        
        </div>
    </div>
</div>

</template>
<script>

export default {
    
    props: ['user', 'info'],

    data() {
        return {
            loading: true,
            awards: [],
            columns: ['id', 'name', 'jobable_type', 'project', 'nation_abbr', 'from_date', 'to_date', 'status', 'updated_at', 'actions'],
                options: {
                    headings: {
                        id: 'Id',
                        name: 'Name',
                        jobable_type: 'Type',
                        project: 'Project',
                        nation_abbr: 'Nation', 
                        from_date: 'From',
                        to_date: 'To',
                        updated_at: 'Bid Time',
                        actions: ''
                    },
                    templates: {                      
                        status: 'status'
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
                        updated_at: 'w-150',
                        actions: 'text-right w-40 action' 
                    },
                    sortable: ['id', 'name', 'jobable_type', 'project', 'nation_abbr', 'from_date', 'to_date', 'status', 'updated_at'],

                    orderBy: {
                        ascending: false,
                        column: 'created_at'
                    }
                    
                }      
        }
    },
    filters: {
        capital(value) {
            return capitalize(value);
        }
    },

    // mounted() {
    //     console.log(this.$access(), sessionStorage.perms);
    // }

}
    

</script>
<template>
<div class="content-wrapper">
    <!-- Page header -->
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
                        <div class="form-group">
                          
                        </div>
                    </div>
                </div>
            </div>
          
            <div class="panel-body">
        
                <div class="row">
                      <v-server-table 
                            
                            url="/api/forms" 
                            :columns="columns" 
                            :options="options">
                            <template slot="code" scope="props">
                                <a :href="props.row.path" download>{{props.row.code}}</a>
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
  
    data() {
        return {
             editMode: (localStorage.getItem('formedit') =="false"? false: true),
             files: [],
             form: new Form( {   
                 id: null,          
                 code: null,
                 name: null,
                 note: null,
                 path: null,
                 fileUpload: null                           
                 
             }),
        
             nations: [],
             columns: ['id', 'code', 'name', 'note', 'actions'],
             options: {

                headings: {
                    actions:  ''
                },        
         
                columnsClasses: {                  
                    id: 'w-70',
                    code: 'w-100',
                    name: 'column-expanded',
                    note: 'w-200',
                    actions: 'text-right w-40 action',
                },
                sortable: ['id', 'code', 'name', 'note']
          
             }
        
        }

    },



}
</script>

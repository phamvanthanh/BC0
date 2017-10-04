<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                          
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
        
                <div class="table-wrapper">
                      <v-client-table 
                            :data="files" 
                            :columns="columns" 
                            :options="options">
                            <template slot="code" scope="props">
                                <a :href="props.row.path" download>{{props.row.code}}</a>
                            </template>

                           
                      </v-client-table>
 
                </div>
            </div>           
         
        </div>
    
    </div>
 

</div>

</template>
<script>
import  ClientTable from 'vue-tables-2';


export default {
  
    data() {
        return {
             editMode: (localStorage.getItem('formedit') =="false"? false: true),
             files: [],
             form: new Form( {   
                 id: null,          
                 code: null,
                 name: null,
                 path: null,
                 fileUpload: null,
                             
                 
             }),
             formData: new FormData({

             }),
             nations: [],
             columns: ['id', 'code', 'name',  'actions'],
             options: {

                headings: {
                    actions:  ''
                },
         
                skin: 'table-hover',
                texts: {
                    filter: 'Filter: '
                },
                columnsClasses: {                  
                    id: 'w-70',
                    code: 'w-80',
                    name: 'column-expanded',
                    actions: 'text-right w-40 action',
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'
                },
                perPage: 25,
                perPageValues: [10,25,50,100]
             }
        
        }

    },
 
    created() {        
        this.getForms(this.pid);
        var _this = this;      
        
        
    },

 
    methods: {

        getForms() {
            axios.get('/api/forms')
                 .then(({data})=>{this.files = data;
                  })
        }, 


    }


}
</script>

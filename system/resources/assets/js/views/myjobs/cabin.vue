<template>
<div id="docs-wrapper">  
     <div v-if="hasFiles">
        <v-client-table 
            :data="files" 
            :columns="columns" 
            :options="options">
            <template slot="name" scope="props">
                <a :href="'/'+props.row.path" target="_blank" > {{props.row.name}} </a>
            </template>
        </v-client-table>
    </div>
    
</div>

</template>
<script>



export default {
    props: {
        folder: {
            id: null,
            name: null,
        },  

        
    },
    data() {
        return {
            files: [],

            columns: [
                'id',          
                'name',       
                'created_at',                
            ],
            
            options: {
                headings: {
                    id: 'Id',                      
                    created_at: 'Created',
                          
                  
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'
                },
             
                columnsClasses: {
                    id: 'w-70',
                    name: 'column-expanded',
                    revision: 'w-70',
                    created_at: 'w-150',                   
                    actions: 'text-right w-40 action',
                },      

                skin: 'table-hover',
                texts: {
                    filter: 'Filter: '
                }

            },         
           
            
        }
    },

    computed: {
        isActive() {
            return (this.folder.id != null);   
        },
        hasFiles() {
            return (this.files.length > 0);
        },
    
    },
    watch: {
        'folder.id': function(val){
            this.getFiles(val);         
          
        }
       
    },


    methods: {

      getFiles(fid){
         axios.get('/api/projects/folders/'+this.folder.id+'/files')
              .then(({data})=>{               
                 this.files = data.map(function(e){
                     return {
                         id: e.id,
                         name: e.name,
                         created_at: moment(e.created_at).format('YY/MM/DD'),
                         path: e.path
                     }
                 })})
              .catch((error)=>{
                 console.log(error)})
     }

   },
   
}
</script>
<style>
i.material-icons {
    display: none !important;
}
#docs-wrapper {
    min-height: 200px;
}
.uploader {    
    overflow-x: hidden;
    overflow-y: hidden;
    min-height: 150px;
    
}
.is-close {
    width: 20px;
    right: -10px;
    position: absolute;
    
}
.dropzone-container {
    z-index: 8;
}
.is-close .dropzone-container {
    display: none;
}
.is-open {
    width: 100%;
    margin-bottom: 20px;
}
div.opener {
    position: absolute;
    height: 100%;
    width: 20px;
    left: 0px;  
    z-index: 9;
    background-color: deepskyblue;
}
div.opener i {
    position:relative;
    top: calc(50% - 10px); /* 50% - 3/4 of icon height */
}
div.is-close div.opener {
    opacity: 1;
}
div.is-open div.opener { 
    opacity: 1;
  
}


</style>
<template>
<div v-if="folder.id" id="docs-wrapper">
    <div :class="{loader:loading}"></div>
    <div :class="{hidden:loading}" v-if="files.length > 0" > 
        
            <v-client-table 
                :data="files" 
                :columns="columns" 
                :options="options">
                <template slot="name" scope="props"  >
                    <a :href="'/'+props.row.path" target="_blank" v-if="props.row.id != edit_id" download>{{props.row.name}}</a>
                    <span v-if="$can('client|superuser|project_director|project_manager')">
                        <form @submit="onSubmit" v-if="props.row.id == edit_id"  >
                            <input id="name-input" :value="props.row.name" v-model="form.name" @blur="onSubmit" @keydown.enter="onSubmit" class="expand" >
                            <input :value="props.row.id"  v-model="form.id" class="hidden">
                        </form>
                    </span>
                </template>
                <template  slot="actions" scope="props">        

                    <ul class="icons-list" v-if="$can('client|superuser|project_director|project_manager')" >
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="icon-menu7"></i>
                            </a>

                            <ul class="dropdown-menu  dropdown-menu-right">
                                <li><a :href="'/'+props.row.path" download target="_blank"  class="text-primary" ><i class="icon-download"></i> Download</a></li>
                                <li><a @click="renameFile(props.row)" class="text-primary" ><i class="icon-pencil3"></i> Rename</a></li>
                                <li><a @click="deleteFile(props.row)" class="text-danger" ><i class="icon-trash-alt" ></i> Delete</a></li>
                            </ul>
                        </li>
                    </ul>
                </template>     

            </v-client-table>
        
    </div>

    <div v-else>                
        <div class="table-norecord">
            <span>No records.</span>
        </div>                
    </div>
    
</div>

</template>
<script>


import {ClientTable} from 'vue-tables-2';

Vue.use(ClientTable, {
    compileTemplates: true,

});


export default {
    props:['folder'],
    data() {
        return {
            loading: true,
            edit_id: null,           
            form: new Form({
                id: null,
                name: null
            }),

            files: [],
            columns: [
                'id',  
                'name',                         
                'created_at',
                'actions'                
            ],
            
            options: {
                headings: {
                    id: 'Id',                      
                    created_at: 'Created',
                    actions: ''         
                  
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'
                },              
                 
                columnsClasses: {
                    id: 'w-80',
                    name: 'column-expanded',                  
                    created_at: 'w-150',                   
                    actions: 'text-right w-40 action',
                      
                },
                perPage: 25,
                perPageValues: [10,25,50,100],
                skin: 'table-hover',
                texts: {
                    filter: ''
                }
            },        
            
        }
    },
    created() {
        let _this = this;
        bus.$on('uploadsuccess', function(){        
            _this.getFiles(_this.folder.id);
        });      

      
    },

    computed: {
        isActive: {
            get() {
                return (this.folder.id != null);   
            },
            set(newVal) {

            }            
        },
        hasFiles() {
            return (this.files.length > 0);
        },
       
    },
    watch: {
        'folder.id': function(val, oldVal){
            if(val != oldVal)
                this.loading = true;
            this.getFiles(val);         
            if(this.$refs.projectdropzone){
                this.$refs.projectdropzone.setOption('url', this.uploadUrl);
                this.$refs.projectdropzone.removeAllFiles();
            }
        },       
    },
  
    methods: {
        
      showSuccess(file) {
        this.getFiles(this.folder.id);
       
      },
      getFiles(fid){
        //    this.loading = true;
           axios.get('/api/projects/folders/'+this.folder.id+'/files')
                .then(({data})=>{               
                    this.files = data.map(function(e){                 
                        return e;
                    });
                    this.loading = false;})
                .catch((error)=>{
                    console.log(error)})
     },
     toggleUploader(){
        this.isOpen = !this.isOpen;
     },

     deleteFile(e) {
            let yes = confirm('Your are deleting this file permanently. You and authorized users will no longer be able to access to this file.');
            if(yes){
                
                var form = new Form({
                    id: e.id,
                    path: e.path
                })
            
                form.post('/api/projects/folders/'+e.folder_id+'/files/delete')
                    .then(({data})=>{
                            notice(form.notifications, 5000);
                            this.getFiles(e.folder_id);
                    })
                    .catch(({error})=>{
                        notice(form.notifications, 5000);
                    })
            }  
       },
       renameFile(e) {
          
           this.edit_id  = e.id;
           this.form.id = e.id;
           this.form.name = e.name;

            setTimeout(function(){
                    $("#name-input").focus()}, 1);
                return;  
       },
       onSubmit() {
           if(this.form.id)
           this.form.post('/api/desk/projects/files')
                    .then(({data})=>{
                        this.edit_id = null;
                        // bus.$emit('refreshfiles');
                        this.form.reset();
                        this.getFiles(this.folder.id);
                        notice(this.form.notifications, 5000);
                        
                    })
                    .catch((error)=>{
                        this.edit_id = null;
                        this.form.reset();
                        notice(this.form.notifications, 5000);
                    })
       }
   },

   
}
</script>
<style>
i.material-icons {
    display: none !important;
}
#docs-wrapper {
    min-height: 150px;
}
.uploader {    
    /*overflow-x: hidden;
    overflow-y: hidden;   */
    /*height: 150px;*/
}
.is-close {
    width: 20px;
    right: -10px;
    position: absolute;
    
}
.dropzone-container {
    z-index: 8;
    min-height: 150px;
}
.is-close .dropzone-container {
    display: none;
}
.is-open {
    width: 100%;
    /*margin-bottom: 20px;*/
}
div.opener {
    position: absolute;
    height: 150px;
    width: 20px;
    left: 0px;  
    z-index: 9;
    background-color: #2196F3;
}
div.opener i {
    position:relative;
    top: calc(50% - 10px); 
}
div.is-close div.opener {
    opacity: 1;
}
div.is-open div.opener { 
    opacity: 1;
  
}


</style>
<template>
<div class="row" v-if="folder.id" >
 
    <v-server-table 
        ref="file_table"
        url='/api/projects/folders/files'
        
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

    </v-server-table>
  
</div>

</template>
<script>



export default {
    props:['folder'],
    data() {
        return {

            edit_id: null,           
            form: new Form({
                id: null,
                name: null
            }),

            columns: [
                'id',  
                'name',                         
                'created_at',
                'actions'                
            ],           
           
            
        }
    },
    created() {
        bus.$on('uploadsuccess', ()=>{
            this.$refs.file_table.refresh();
        })
    },
  

    computed: {

        options() {
                return {
                    headings: {
                        id: 'Id',                      
                        created_at: 'Created',
                        actions: ''         
                  
                    },
                    sortable: ['id', 'name', 'created_at'],       
                    
                    columnsClasses: {
                        id: 'w-80',
                        name: 'column-expanded',                  
                        created_at: 'w-150',                   
                        actions: 'text-right w-40 action',
                        
                    },
                    params: {
                        folder_id: this.folder.id
                    }

                }
        },
    
        isActive: {
            get() {
                return (this.folder.id != null);   
            },
            set(newVal) {

            }            
        },
   
       
    },
    watch: {
        'folder.id': function(val, oldVal){
            if(val != oldVal && oldVal != undefined)     
            setTimeout(()=>{
                this.$refs.file_table.refresh();
            }, 1);      
              
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
                        notice(form.notifications, 6000);
                        this.$refs.file_table.refresh();
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
                        this.$refs.file_table.refresh();
                        this.form.reset();
                       
                        notice(this.form.notifications, 6000);
                        
                    })
                    .catch((error)=>{
                        this.edit_id = null;
                        this.form.reset();
                        notice(this.form.notifications, 6000);
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
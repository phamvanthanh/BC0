<template>   
    <li  v-bind:class="{active: isActive}"  class="tablinks" >        
         <span v-if="!isEdit">
            <a @click="activate"  >{{folder.name}}</a>
            <span v-if='$can("client|project_director|superuser|project_manager")'   class="pull-right" >                
                <ul class="icons-list" >
                    <li class="dropdown">
                        <a  href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="menu-icon  icon-arrow-down5"></i>
                        </a>

                        <ul class="dropdown-menu  dropdown-menu-right">
                            <li><a @click="upload" class="text-primary" ><i class="icon-upload"></i> Upload Files</a></li>
                            <li><a @click="editFolder" class="text-primary" ><i class="icon-pencil3"></i> Rename</a></li>
                            <li><a @click="deleteFolder" class="text-danger" ><i class="icon-trash-alt" ></i> Delete</a></li>
                        </ul>
                    </li>
                </ul>
            </span>
        </span>
        <span class="folder-edit" v-if="isEdit">
            <form  @submit.prevent="onSubmit" method="post" v-if='$can("client|project_director|superuser|project_manager")' >                   
                <input name="existingfolder" id="folderInput" type="text"  v-model="form.name" placeholder="name" required style="width: 100%" @blur.prevent="onSubmit" >	

            </form>	
        </span> 

         <uploader v-if="showModal"
                   :url="url"
                   width="800"
                   >

        </uploader>  

         

    </li>   
</template>
<script>
import uploader from './uploadFileModal';
export default {
    props: ['folder'],
    components: {
        uploader,
    },
    computed: {
        url: {
            get() {
                return '/api/projects/folders/'+this.folder.id+'/files/post';
            },
            set(newVal) {

            }
        }
    },
    data() {
        return {
            pid: this.$route.params.pid,
            showModal: false,           
            isActive: false,
            form: new Form({
                id: null,
                project_id: null,
                name: null
            }), 
            isEdit: false
        }
    },

    created() {
        let _this = this;
        this.$on('close', function(){      
            _this.showModal = false;
        })
      
    },

    methods: {
         activate(){                            
            var i;
            for(i=0; i < this.$parent.$children.length; i++){                          
                this.$parent.$children[i].isActive = false;
            }
            this.isActive = true;
            bus.$emit('activefolder', this.folder)
            
        },
        deleteFolder() {
             var yes = confirm('You are about to delete the folder permanently. All system will not be able to access files contained in this folder.');
             if(yes){
                 this.form.id = this.folder.id;
                 this.form.name = this.folder.name;
                 this.form.post('/api/projects/'+this.pid+'/folders/delete')
                          .then(({data})=>{
                              notice(this.form.notifications, 5000);                              
                              bus.$emit('refreshfolders');
                              bus.$emit('activefolder', {id: null, name: null});
                          })
                          .catch(({error})=>{notice(this.form.notifications, 5000);})
             }
        },
        editFolder() {
           
                 this.isEdit = true;
                 this.form.id = this.folder.id;
                 this.form.project_id = this.folder.project_id;
                 this.form.name = this.folder.name;
                 
                 setTimeout(function(){
                     $("#folderInput").focus()}, 1);
                 return;       
           
            
        },
        onSubmit() {
           // console.log("Fire");
            if(this.form.name == null  || this.form.name == '') {              
                this.close();
            }                
            else {
                  this.form.post('/api/projects/'+this.pid+'/folders')
                        .then(({data})=>{
                            this.close();                           
                            notice(this.form.notifications, 6000); 
                            this.isNewFolder = false; })
                        .catch(({error})=>{
                            notice(this.form.notifications, 6000); })
            }                 

        },
        close() {
            this.isEdit = false;
            this.form.reset();
        },
        upload() {
            this.showModal = true;
        }
    }
}

</script>


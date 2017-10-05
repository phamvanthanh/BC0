<template >
     <div class="folder-wrapper" >   
        <div id="folder-heading"><span >Folders</span></div> 
        <div :class="{loader:loading}"></div>
        
        <ul :class="{hidden:loading}"   id="folder-list" class="pd-0"  >      
            <foldercomp v-for="folder in folders"
                v-bind:key="folder.id"
                v-bind:folder="folder"
                v-bind:edit="edit">
            </foldercomp>
            <li >
                <span v-if="isNewFolder">
                    <form @submit.prevent="onSubmit" method="post"  >                   
                        <input name="newfolder" id="folderInput" type="text"  v-model="form.name" placeholder="name" required style="width: 100%" @blur.prevent="onSubmit" @keyup.enter.prevent="onSubmit" >    
                    </form>										
                </span>
                <span v-else @click="newFolder"   ><span    class="add">+</span></span>
            </li>
        </ul> 
            
    </div>
</template>

<script>
import foldercomp from './folder';

export default {
    props:['id', 'edit'], // Project id
    data() {
        return {
            
            loading: true,
            isNewFolder: false,
            form : new Form({
                id: null,
                project_id: this.$route.params.pid,       
                name: null
            }),
            
            folders: [],
            
        }
    },

    created: function(){
        this.getFolders(this.id);
        let _this= this;
        bus.$on('refreshfolders', function(){
            _this.getFolders(_this.id);
        });
    
       
    },
    mounted: function() {
        let _this = this;
       
     
    },
    components: {
        foldercomp,
       
    },
    methods: {
        getFolders(id) {
             axios.get('/api/projects/'+id+"/folders")
                  .then(({data})=>{ 
                      this.folders = data;
                      this.loading = false;
                  })
                  .catch((errros)=>console.log(errors))          
        },

        onSubmit() {
            if(this.isNewFolder) {
                this.isNewFolder = false;
                if(this.form.name == null  || this.form.name == '') {              
                    this.cancel();
                }                
                else {
                    this.form.post('/api/projects/'+this.id+'/folders')
                        .then(({data})=>{
                            this.getFolders(this.id);
                            this.form.id = null;
                            this.form.name = null;                        
                            notice(this.form.notifications, 6000); 
                            
                            })
                        .catch(({error})=>{
                            notice(this.form.notifications, 6000); })
                }     
                
            }
                         

        },
        newFolder() {
            this.isNewFolder = true;
            setTimeout(function(){
                     $("#folderInput").focus()}, 1);
        },
       
        cancel() {
            this.isNewFolder = false;
        }      
     
    }
  
}

</script>
<style lang="scss">
@import './../../../sass/components/_variables';

.folder-wrapper {
    float: left;
    border:none;
    background-color: $default-bg;
    width: 100%;
    padding: 5px 0px;
  
}

#folder-heading {
    padding: 5px;
}


ul#folder-list > li
 {
    display: block;
    background-color: inherit;   
    width: 100%;
    border-left: 4px solid transparent;
    outline: none;
    text-align: left;    
    transition: 0.3s;
    box-sizing: border-box;
    padding: 3px 5px 3px 20px; 
   
}




ul#folder-list > li.active{

  font-weight: $font-weight-focus;
  border-left-color: $warning-color;

}

ul#folder-list > li:hover {
    border-left-color: $warning-color;
   
}

#folder-list li.active i.menu-icon {
  /*color: $text-white;*/
  
}
ul.dropdown-menu li {
    padding: 0px;
}
#folder-listcontent {
    float: left;
    padding: 0px 12px;
    border: 1px solid #ccc;
    width: 70%;
    border-left: none;
    height: 300px;
}
</style>

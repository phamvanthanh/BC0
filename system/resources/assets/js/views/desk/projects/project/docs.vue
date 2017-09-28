<template >
    <div class="panel panel-flat">
        <div id="doc-heading" class="panel-heading" > 	              
            <div class="heading-elements">
                <div class="heading-btn">
                    <div class="form-group">
                       
                    </div>
                </div>                   
            </div>
        </div>
        
        <div class="panel-body">        
            <div class="row">
                <div class="col-sm-3">                   
                    <folders
                        :id="id">
                    </folders> 
                </div>
                <div class="col-sm-9">
                    <cabin :folder="activefolder"
                            >
                    </cabin>                   
                </div>
            </div>            
        </div>       
    </div>
</template>
<script>

import folders from './../../../elements/folders';
import cabin from './../../../elements/cabin';

export default { 
    props: ['project_id'],
    computed: {
      id: {
        get() {
          return this.project_id;
        },
        set() {

        }
      }
    },
    data() {
        return {           
  
            activefolder: {
                id: null,
                name: null
            }           
        }
    },
    created: function(){
      
        let _this= this;
     
        bus.$on('activefolder', function(e) {
            _this.activefolder = e;
        });
       
    },

    components: {      
        folders,
        cabin       
    },
    methods: {  
  
        cancel() {
            this.isNewFolder = false;
        }
    }


}
</script>

<style lang="scss">
span.folder-edit input {

  color: #333333 !important;
}


</style>
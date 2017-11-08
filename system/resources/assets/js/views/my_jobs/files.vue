<template  >
    <div class="panel panel-flat">
        <div class="panel-heading"> 
          	              
            <div class="heading-elements">
                <div class="heading-btn">
                    
                </div>                   
            </div>
        </div>
        
        <div class="panel-body">
        
            <div class="row">
                <div class="col-sm-3">                   
                    
                   <folders
                    :id="info.project.id">

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

import folders from './../elements/folders';
import cabin from './../elements/cabin';

export default {  
    props: ['info'],
    data() {
        return {        
                        
            folders: [],
            activefolder: {
                id: null,
                name: null
            }           
        }
    },

    mounted: function(){  
        let _this= this;    
        bus.$on('activefolder', function(e) {  
            _this.activefolder = e;
        });
       
    },
   
    components: {
     
        folders,
        cabin
       
    },



}
</script>

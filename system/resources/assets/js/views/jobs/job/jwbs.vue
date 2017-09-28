<template>

        <div class="panel panel-flat">
            <div :class="{loader:loading}"></div>
            <div :class="{hidden:loading}" class="panel-heading">
                <slot name="jwbs-title"></slot>
              
                <div class="heading-elements">
                
                </div>
            </div>
          
            <div :class="{hidden:loading}" class="panel-body">
                <ul  class="ui-fancytree fancytree-container fancytree-plain"  >
                    <jwbs										
                        :node="jwbs" >
                    </jwbs>           
                </ul> 
                           
            </div>            
         
        </div>

 

</template>
<script>


import jwbs from './../../elements/pwbs'; 


export default {  
    data() {
        return {                       
            loading: true,
            jwbs: [],                
              
        }
    },
    props: {
        info:{}
    },
    created() { 
  
        this.getJwbs(this.info.id);
        
        
    },
    watch: {
        'info.id': function () {
            this.getJwbs(this.info.id);
        }         
         
    },

    components: {    
        jwbs,
         
    },
    methods: { 
       
        getJwbs(id) {    
             if(this.info.id)
            axios.get('/api/jobs/'+id+'/jwbs')
                 .then(({data})=>{
                     this.jwbs = data; 
                     this.loading = false;
                    })
                 .catch((error)=>{console.log(error)});
        }, 

    }


}
</script>
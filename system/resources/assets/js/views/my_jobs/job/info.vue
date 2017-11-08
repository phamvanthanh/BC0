<template  >

    <div class="panel panel-flat">
            <div class="panel-heading">
      
                <div class="heading-elements">
                    <slot name="buttons"></slot>
              
                </div>
            </div>
          
            <div class="panel-body">
                <div class="row">    
                    <div class="col-md-3">
                        Name: {{info.jobable.name}}<br>
                        Type: {{info.jobable_type | capital}}</br>

                    </div>
                    <div class="col-md-3">
                        
                        Project: {{info.project.name}}</br>
                        Industry: {{info.project.industry.name}}

                    </div>
                    <div class="col-md-3">
                        
                        Awarded On: {{info.awarded.created_at}}</br>
                        Timeframe: {{info.from_date}} -> {{info.to_date}}

                    </div>
                    <div class="col-md-3 text-right">
                        Status: <span :class="[info.status == 'active'? 'label-success':  'label-default', 'label']">{{info.status | capital}}</span><br>

                    </div>
                    <div class="col-md-12">
                        <h6>Description</h6>
                        <pre>{{info.jobable.description}}</pre>
                    </div>
                    <div v-if="info.jobable_type == 'project'" class="col-md-12">
                        <h6>Requirements</h6>
                        <pre>{{info.jobable.requirement}}</pre>
                    </div>
                </div>
                
         
                
            </div>          
           
         
        </div>

</template>

<script>
   
 
export default { 
    name: 'info',     
       
    props: {
          info:null
    },

   filters: {
        capital(value) {
            return capitalize(value);
        }
    },
       
       
     
       
      
}
</script>

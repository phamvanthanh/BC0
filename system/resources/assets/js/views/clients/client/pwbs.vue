<template>

    <div class="panel panel-flat" >
      <div class="panel-heading">	
        <input id="pwbs-search" @keyup="pwbsSearch" placeholder="Search..." >
        <div class="heading-elements">
          <div class="heading-btn">
            <div class="form-group">             
                    							
              
            </div>								
          </div>
          
        </div>					
      </div>
    
      <div class="panel-body"  >						
              
          <div  class="col-md-12">
          
              <ul id="pwbs-static-ul">							
                  <pwbs										
                      :node="pwbs" 
                      :filterString="filterString" >
                  </pwbs>
              </ul>	
           
          </div>
     					
      </div>
   
    </div>		
  
</template>
<script>

import pwbs from './../../elements/pwbs';


export default {
    props: ['id'],
    data() {
        return {

            pwbs: [],      
            filterString: '',
        }
    },
    created() {        
        this.getPwbs(this.id);  
    },

    components: {

        pwbs,
   
    },

    methods: {

      getPwbs(pid) {
        axios.get('/api/projects/'+this.id+'/pwbs') 
            .then(({data})=>{this.pwbs = data});
      },

      pwbsSearch(event) {
          this.filterString = event.target.value;
      }    
    }
}

  

</script>



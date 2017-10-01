<template>

    <div v-if="isNotified" class="notify-bar" :class="messageClass" >
        
        <span class="help is-danger" >Response code: {{warns.status}} : </span>
        <span class="help is-danger" ><strong  >{{warns.stausText}} </strong></span>
        <span v-for="error in warns.data" class="help is-danger" >
            {{typeof(error) == 'object'? error[0]: error }}  /
        </span>
        
    </div>
   

</template>
<script>
    export default {
        props: ['warns'],                   
    
        computed: {
            isNotified: function (){
              
                if(this.warns != null){                   
                    return true;  
                }                  
            }, 

            messageClass: 
            {
              get: function() {
                    if(this.warns){}
                    if(this.warns.status < 300)
                        return 'succeed';
                    if(this.warns.status >= 400 && this.warns.status >300)
                        return 'failed';
                    if(this.warns.status >=500)
                        return 'danger';
              },
              set:  function(newVal)  {
                  
             },
           }
     
            
        },

        watch: {
            warns: function(val, oldVal) {
                 if(val) {
                    if(val.status < 300)
                        this.messageClass =  'succeed';
                    if(val.status >= 400 && val.status >300)
                        this.messageClass =  'failed';
                    if(val.status >=500)
                        this.messageClass =  'danger';
                 }                   

            }
        }   
    }

</script>
<style>
.notify-bar {
  position: fixed;
  height: 30px;
  width: 100%;
  bottom: 0px;
  padding: 4px 12px;
  overflow-x: hidden

}
.danger {
    background-color: #ffdddd;
    border-left: 6px solid #f44336;
}
.failed {
    background-color: #ffffcc;
    border-left: 6px solid #ff9800;
}
.succeed {
    background-color: #ddffdd;
    border-left: 6px solid #4CAF50;
}
</style>





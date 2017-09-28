<template  >

    <div class="panel panel-flat">
            <div class="panel-heading">              
                <div class="heading-elements">
                    <span v-if="displayBid">
                        <span v-if="bidable"  @click="bid" >
                            <slot name="buttons" ></slot>
                        </span>
                            <slot name="editbtn"></slot>
                       
                    </span>
                </div>
            </div>
          
            <div class="panel-body">
                <div  class="row"> 
                       
                    <div class="col-md-5">
                        Name: {{info.jobable.name}}<br>
                        Type: {{info.jobable_type | capital}}<br>
                        Project: {{info.project.name}}<br>
                        Nation: {{info.project.nation.name }}

                    </div>
                    <div class="col-md-5">                     
                        
                        Industry: {{info.project.industry.name}}<br>
                        Timeframe: {{info.from_date}} to {{info.to_date}}<br>
                        <slot name="awarded"></slot>
                        Status: <span :class="['label', info.status == 'active'? 'label-success': 'label-default']" >{{info.status | capital}}</span>    
                        

                    </div>
                    <div class="col-md-2 text-right">
                        <span v-if="!bidable">
                            <span v-if="isBidden" class="label label-success" >
                                Already bid
                            </span>
                           
                            <span v-else-if="!checkRoleFor(info.jobable_type)" class="label label-warning" >
                                <span> {{info.jobable_type == 'project'? 'Require Project Manager' : info.jobable_type == 'section'? 'Require Controller' : 'Require Surveyor'}} </span>
                            </span>

                        </span>
                 

                    </div>
                   
                    <div class="col-md-12">
                        <span>Description</span><br>
                        <span class="pl-10"><pre>{{info.jobable.description}}</pre></span>
                    </div>
                    <div v-if="info.jobable_type == 'project'" class="col-md-12">
                        <span>Requirements</span><br>
                        <span class="pl-10"><pre>{{info.jobable.requirement}}</pre></span>
                    </div>
                </div>      
         
                
            </div>          
           
         
        </div>

</template>

<script>
   
 
export default { 
    props: ['info'],     
    data() {
        return {
            form: new Form ({
                job_id: null,
                user_id: null
            }),
            displayBid: true
        }
    }, 
    filters: {
        capital(value){
            return capitalize(value);
        }
    },
    computed: {
        user() {
            return this.$store.state.user;
        },
    
        isBidden() {
            var isBidden = false;
            if(this.info.bids) {
                for(let index in this.info.bids) {                  
                    if(this.info.bids[index].user_id == this.user.id) {
                        isBidden = true;
                        break;
                    } 
                }
            }
            return isBidden;

        },
        bidable() {      
      
            return this.checkRoleFor(this.info.jobable_type) && !this.isBidden && this.info.status == 'active';
        }  
    },
    methods: {
         bid() {
        
            this.form.user_id = this.user.id,
            this.form.job_id = this.info.id;
            this.form.post('/api/works/'+this.info.id+'/bids')
                     .then(({data})=>{
                         this.displayBid = false;
                         notice(this.form.notifications, 6000);
                        })
                     .catch((error)=>{
                         notice(this.form.notifications, 6000);
                     })

        },

         checkRoleFor(type) {
              let checkString = '';
              switch(type) {
                case 'project':
                    checkString = 'project_manager';
                    break;
                case 'section':
                    checkString = 'qto_controller';                       
                    break;
                case 'package':
                    checkString = 'surveyor'; 
                    break;
                default:
                    return false;
              }

            for(  var i=0;  i < this.user.roles.length; i++) {
                  
                if(this.user.roles[i].name === checkString)  
                    return  true;
            }
              
            return false;
        },
      
    }      
      
}
</script>

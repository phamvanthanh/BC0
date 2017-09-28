<template>
<div>
   <jobinfo :info="info">       
       <span v-if="info.awarded" slot="awarded">Awarded to: {{ info.awarded.user.first_name }} {{ info.awarded.user.last_name }}<br></span>
       <span slot="editbtn">         
           <a @click="editJob" ><i class="icon-pencil7"></i> Jobable </a>
        </span>
    </jobinfo>
</div>
</template>
<script>
import jobinfo from './../../../jobs/job/info';



export default {
 
    // router,
  
    props: {
        info: null
    },

    components: {
        jobinfo
    },
    methods: {
        editJob() {
             let _this = this;
            if(this.info.jobable_type == 'project') {   
                 this.$router.push({ name: 'desk.project.info', params: { pid: this.info.project.id }});
            }

            if(this.info.jobable_type == 'section') {
                var payload = {
                    id: this.info.jobable_id,
                    name: this.info.jobable.name,
                    from_date: this.info.from_date,
                    to_date: this.info.to_date,
                    status: this.info.status,
                    description: this.info.jobable.description
                }

           
                this.$router.push({ name: 'desk.project.sections', params: { pid: this.info.project.id }});
                setTimeout(function(){
                    bus.$emit('editgroup', payload)
                
                }, 5);
            }
            if(this.info.jobable_type == 'package'){
                var payload = {
                    id: this.info.jobable_id
                }
                this.info.jobable.job = {};
                this.info.jobable.from_date = this.info.from_date;
                this.info.jobable.to_date = this.info.to_date;
                this.info.jobable.status = this.info.status;
               
                router.push({ name: 'desk.project.section.packages', params: { pid: this.info.project.id, gid: this.info.jobable.group_id }});
               
                setTimeout(function(){bus.$emit('editpackage', _this.info.jobable)}, 1);
            }    
            
        }
    }
}
</script>
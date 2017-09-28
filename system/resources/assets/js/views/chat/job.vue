<template>
    <div class="display-td text-primary">
        <span class="fw-600 fs-15">#{{job.job_id}}</span> - 
        <span >{{job.jobable_type | capital}} {{job.name}}</span>
        <span v-if="number>0" class="badge">{{number}}</span>
        <span class="text-muted display-block fs-11" >Project {{job.project}}</span>

    </div>
</template>
<script>
export default {
    props: ['job'],
    data() {
        return {
            number: null
        }
    },
    created() {
        
        this.unreads();  
        bus.$on('countunreads',(job_id)=>{
            if(this.job.job_id == job_id)
               this.unreads();
        });
    },
    
    filters: {
        capital(val) {
            return capitalize(val);
        }
    },
    methods: {
        unreads() {
			
            if(this.job.private)
                axios.get('/api/messages/from/'+this.job.job_id+'/to/'+this.job.co_job_id)
                    .then(({data})=>{ this.number = data})
                    .catch((error)=>{console.log(error)});	
            else
                axios.get('/api/messages/from/any/to/'+this.job.job_id)
                    .then(({data})=>{ this.number = data})
                    .catch((error)=>{console.log(error)});	

           
         

		}
    }
}
</script>

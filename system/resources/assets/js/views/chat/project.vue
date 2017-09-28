<template>
    <div class="display-td text-primary">
        <span class="fw-600 fs-15">#{{project.job_id}}</span> - 
        <span >{{project.jobable_type | capital}} {{project.name}}</span>
        <span v-if="number>0" class="badge">{{number}}</span>
    </div>
</template>
<script>
export default {
    props: ['project'],
    data() {
        return {
            number: null
        }
    },
    created() {        
        this.unreads();  
        bus.$on('countunreads',(job_id)=>{
            if(this.project.job_id == job_id)
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
           axios.get('/api/messages/from/'+this.project.job_id+'/to/'+this.project.job_id)
                .then(({data})=>{ this.number = data})
                .catch((error)=>{console.log(error)});	
        
		}
    }
}
</script>

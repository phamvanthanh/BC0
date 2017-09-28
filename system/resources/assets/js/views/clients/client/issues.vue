<template>
<div> 

<router-view :pid="pid"
             :job_id="job_id" >
            
             
</router-view>

</div>
 
</template>
<script>

export default {
    props: ['pid', 'job_id'],

  

}

</script>
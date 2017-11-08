<template>

        <router-view 
            :job_id="job_id" 
        >
        </router-view>

 
</template>
<script>


export default {
    //Receive job_id to pass to children
    props: ['job_id'], 

}

</script>
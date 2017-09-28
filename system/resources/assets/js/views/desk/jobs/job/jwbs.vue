<template>
    <jwbs :info="info">
        
    </jwbs>
</template>
<script>
import jwbs from './../../../jobs/job/jwbs';
    export default {
        props: ['info'],
        components: {
            jwbs
        }
    }
</script>
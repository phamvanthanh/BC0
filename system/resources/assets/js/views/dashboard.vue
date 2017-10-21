<template>
<div >
    <div class="col-md-6">
         <projects>
    
        </projects>
    </div>
</div>
   

</template>

<script>
import projects from './dashboards/projects.vue';
import qtoc from './dashboards/qtoController.vue';
import qs from './dashboards/surveyor.vue';
import admin from './dashboards/admin.vue';
import client from './dashboards/client.vue';

    export default {
        props: ['role'],
        data() {
            return {

                
            }
            
        },
        computed: {
            
        },
        mounted() {
        
              
        },
        components: {
            projects,
            qtoc,
            qs,
            admin,
            client

        }
    }
</script>

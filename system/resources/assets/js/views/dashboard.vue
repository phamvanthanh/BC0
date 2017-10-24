<template>
<div >
    <div class="col-md-6">
         <projects>
    
        </projects>
    </div>
    <div class="col-md-6">
         <jobs>
    
        </jobs>
    </div>
    <div class="col-md-6">
        <leads>
        </leads>
    </div>
    <div class="col-md-6">
        <clients>
        </clients>
    </div>
    <div class="col-md-6">
        <issues>
        </issues>
    </div>
     <div class="col-md-10">
        <newjobs>
        </newjobs>
    </div>
     <div class="col-md-10">
        <newprojects>
        </newprojects>
    </div>
</div>
   

</template>

<script>
import projects from './dashboards/projects.vue';
import jobs from './dashboards/jobs.vue';
import leads from './dashboards/leads.vue';
import clients from './dashboards/clients.vue';
import issues from './dashboards/issues.vue';
import newjobs from './dashboards/newjobs.vue';
import newprojects from './dashboards/newprojects.vue';
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
            jobs,
            leads,
            clients,
            issues,
            newjobs,
            newprojects           

        }
    }
</script>

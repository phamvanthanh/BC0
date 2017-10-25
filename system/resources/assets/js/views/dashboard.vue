<template>
<div >
    <div v-if='$can("superuser|admin|project_director")' class="col-md-6">
         <projects>
    
        </projects>
    </div>
    <div v-if='$can("superuser|admin|project_director")' class="col-md-6">
         <jobs>
    
        </jobs>
    </div>
    <div v-if='$can("superuser|admin")' class="col-md-6">
        <leads>
        </leads>
    </div>
    <div v-if='$can("superuser|admin")' class="col-md-6">
        <clients>
        </clients>
    </div>
    <div v-if='$can("superuser|admin|project_director")' class="col-md-6">
        <issues>
        </issues>
    </div>
     <div class="col-md-8">
        <newjobs>
        </newjobs>
    </div>
     <div class="col-md-8">
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

<template  >
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                     <router-link :to="{name:'client.project.info', params: {pid: pid}}" class="btn btn-link btn-float has-text">     <i class="icon-info22"></i><span>Info</span></router-link> 
                     <router-link :to="{name:'client.project.files', params: {pid: pid}}" class="btn btn-link btn-float has-text">    <i class="icon-files-empty"></i><span>Files</span></router-link>
                     <router-link :to="{name:'client.project.links', params: {pid: pid}}" class="btn btn-link btn-float has-text">    <i class="icon-link"></i><span>Links</span></router-link>                    
                     <router-link :to="{name:'client.project.pwbs', params: {pid: pid}}" class="btn btn-link btn-float has-text">     <i class="icon-list-ordered"></i><span>Pwbs</span></router-link>                      
                     <router-link :to="{name:'client.project.reports', params: {pid: pid }}" class="btn btn-link btn-float has-text"> <i class="icon-statistics"></i><span>Reports</span></router-link>                  
                     <router-link :to="{name:'client.project.quantity', params: {pid: pid }}" class="btn btn-link btn-float has-text"> <i class="icon-table2"></i><span>Quantity</span></router-link>                     
                     <router-link :to="{name:'client.project.issues', params: {pid: pid }}" class="btn btn-link btn-float has-text">  <i class="icon-notification2"></i><span>Issues</span></router-link>   
                </div>
            </div>
        </div>   
    </div>

    <div class="content">
        <div :class="{loader:loading}"></div>
        <router-view 
            v-if="project.job.id"
            :pid="pid" 
            :project_id="pid"
            :id="pid"
            :job_id="project.job.id"
            :job="project.job" >
        </router-view>   
         <notify :warns="$store.state.notifications"></notify>
    </div>

</div>
</template>

<script>
  
import notify from './../../../core/Notify';

export default {
    data() {
        return {
            loading: true,
            pid : this.$route.params.pid,
            project: {
                job: {
                    id: null,
                }
            },
        }
    },
    
    created() {
        if(this.pid)
        this.getProject(this.pid);
    },     
    
    components: {                    
        notify                   
    },
    methods: {
        
        getProject(id) {
            axios.get('/api/projects/'+id)
                    .then(({data})=>{
                        this.$store.commit('loadItem', {label:'Project', name: data.name});

                        this.project = data;
                        this.loading = false;
                    })
                    .catch(({error})=>{console.log(error)})
        },
       
    }
    
}
</script>

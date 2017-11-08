<template>

<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
              <page-label></page-label>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                  
                        <router-link :to="{name: 'my_job.info', params: { id: id }}" class="btn btn-link btn-float has-text"><i class=" icon-info22"></i><span>Info</span></router-link>     
                        <router-link :to="{name: 'my_job.jwbs', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-tree5"></i><span>Jwbs</span></router-link>        
                        <router-link v-if="info.jobable_type == 'project'" :to="{name: 'my_job.units', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-pencil-ruler"></i><span>Units</span></router-link>
                        <router-link :to="{name: 'my_job.files', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-files-empty"></i><span>Files</span></router-link>
                        <router-link :to="{name: 'my_job.links', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-link"></i><span>Links</span></router-link>
                        <router-link v-if="info.jobable_type == 'project'" :to="{name:'my_job.org', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-tree7"></i><span>Org</span></router-link>  
                        <router-link v-if="info.jobable_type == 'package'" :to="{name: 'my_job.quantity', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-table2"></i><span>Quantity</span></router-link>
                        <router-link v-if="info.jobable_type == 'section'" :to="{name: 'my_job.packages', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-cube3"></i><span>Packages</span></router-link>
                        <router-link v-if="info.jobable_type == 'section'" :to="{name: 'my_job.summary', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-sigma"></i><span>Section Sum</span></router-link>
                        <router-link v-if="info.jobable_type == 'project'" :to="{name: 'my_job.sections', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-page-break2"></i><span>Sections</span></router-link>
                        <router-link v-if="info.jobable_type == 'project'" :to="{name: 'my_job.psum', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-sigma"></i><span>Summary</span></router-link>
                        <router-link v-if="info.jobable_type == 'project' || info.jobable_type == 'group'" :to="{name: 'my_job.reports', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-statistics"></i><span>Reports</span></router-link>
                        <router-link :to="{name: 'my_job.issues', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-notification2"></i><span>Issues</span></router-link>
                  
                </div>
            </div>
        </div>

    
    </div>


    <div class="content">
        <div :class="{loader:loading}"></div>
         <router-view 
            v-if="info.id"
            :class="{hidden:loading}"
            :info="info" 
            :job="info"
            :job_id="info.id"
            :project_id="info.project.id"
         ></router-view>      
         <notify :warns="$store.state.notifications"></notify>
    </div>

</div>

</template>
<script>

import notify from './../../core/Notify';
export default {
    props: {
       user: null        
    },
    data() {
        return {
            loading: true,
            id: this.$route.params.id,
            info: {
                id: null,
                status: null,
                awarded: { 
                    created_at: null,
                    updated_at: null
                },
                project: { 
                    name: null,
                    industry: {
                        name: null 
                    }
                },   
                jobable_type: null,              
                jobable: {},
                bids: []
            } 
        }
    },
  
    components: {
        notify
    },
    created() {       
        this.getJob();
    },

    computed: {
        pid: function() {
            if(this.info.jobable_type == 'project')
                return this.info.jobable_id
        }
    },
   
    methods: {
        
        getJob() {
           
            axios.get('/api/jobs/'+this.id)
                 .then(({data})=>{this.info = data;
                     this.$store.commit('loadItem', {label:'Job', name: data.jobable.name});
                     this.loading = false;
                  })
                 .catch((error)=>console.log(error));
        },
       
    }
    


}
    

</script>
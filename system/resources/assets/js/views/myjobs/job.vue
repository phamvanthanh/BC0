<template>

<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
              <window-heading2></window-heading2>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                  
                        <router-link :to="{name: 'myjob.info', params: { id: id }}" class="btn btn-link btn-float has-text"><i class=" icon-info22"></i><span>Info</span></router-link>     
                        <router-link :to="{name: 'myjob.jwbs', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-tree5"></i><span>Jwbs</span></router-link>        
                        <router-link v-if="info.jobable_type == 'project'" :to="{name: 'myjob.units', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-pencil-ruler"></i><span>Units</span></router-link>
                        <router-link :to="{name: 'myjob.files', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-files-empty"></i><span>Files</span></router-link>
                        <router-link :to="{name: 'myjob.links', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-link"></i><span>Links</span></router-link>
                        <router-link v-if="info.jobable_type == 'package'" :to="{name: 'myjob.quantity', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-table2"></i><span>Quantity</span></router-link>
                        <router-link v-if="info.jobable_type == 'section'" :to="{name: 'myjob.packages', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-cube3"></i><span>Packages</span></router-link>
                        <router-link v-if="info.jobable_type == 'section'" :to="{name: 'myjob.summary', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-sigma"></i><span>Section Sum</span></router-link>
                        <router-link v-if="info.jobable_type == 'project'" :to="{name: 'myjob.sections', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-page-break2"></i><span>Sections</span></router-link>
                        <router-link v-if="info.jobable_type == 'project'" :to="{name: 'myjob.psum', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-sigma"></i><span>Summary</span></router-link>
                        <router-link v-if="info.jobable_type == 'project' || info.jobable_type == 'group'" :to="{name: 'myjob.reports', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-statistics"></i><span>Reports</span></router-link>
                        <router-link :to="{name: 'myjob.issues', params: { id: id }}" class="btn btn-link btn-float has-text"><i class="icon-notification2"></i><span>Issues</span></router-link>
                  
                </div>
            </div>
        </div>

    
    </div>


    <div class="content">
        <div :class="{loader:loading}"></div>
         <router-view 
            :class="{hidden:loading}"
            :info="info" 
            :job_id="info.id"
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
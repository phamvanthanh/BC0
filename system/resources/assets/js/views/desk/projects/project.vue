<template  >
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header subnav">
        <div class="page-header-content">
            <div class="page-title">
                <page-label></page-label>
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" ref="subnav" v-if="subnav" >
                     <router-link :to="{name:'desk.project.info', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class=" icon-info22 "></i><span>Info</span></router-link> 
                     <router-link :to="{name:'desk.project.files', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-files-empty"></i><span>Files</span></router-link>
                     <router-link :to="{name:'desk.project.links', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-link"></i><span>Links</span></router-link>                    
                     <router-link :to="{name:'desk.project.pwbs', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-tree5 "></i><span>Pwbs</span></router-link> 
                     <router-link :to="{name:'desk.project.units', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-pencil-ruler"></i><span>Units</span></router-link> 
                     <router-link :to="{name:'desk.project.org', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-tree7"></i><span>Org</span></router-link>  
                     <router-link :to="{name:'desk.project.sections', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-git-branch"></i><span>S&P</span></router-link>                    
                     <router-link :to="{name:'desk.project.reports', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-statistics"></i><span>Reports</span></router-link>
                     <router-link :to="{name:'desk.project.quantity', params: {pid: id}}" class="btn btn-link btn-float has-text"><i class="icon-table2"></i><span>Quantity</span></router-link>
                     
                </div>
                 <div class="heading-btn-group" v-else >
                    <alter-subnav
                        :routes="routes"
                    ></alter-subnav>    
                </div>
            </div>
        </div>
    
    </div>
    <!-- /page header -->

    <!-- Content area -->
    <div class="content">
        <div :class="{loader:loading}"></div> 

        <router-view 
            :class="{hidden:loading}"
            :project_id="id"
            :job="project">
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
                 subnav: true,
                 routes: [],
                 id : this.$route.params.pid,
                 project: null,
            }
        },   
       
        components: {   
            notify,                     
        },
        created() {
            bus.$on('alternav', (payload)=>{
               
                this.routes = payload;
                this.subnav = false;
            });
            bus.$on('closealternav', ()=>{
                this.subnav = true;
            })
        },
        mounted() {
            this.getProject();
            
        },
        methods: {
       
            getProject() {
                 axios.get('/api/projects/'+this.id)
                .then(({data})=> {
                    
                    this.$store.commit('loadItem', {label:'Project', name: data.name});
                    this.project = data.job;
                    this.loading = false;
                });

            }
        }
      
    }
</script>

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
                      
                        <router-link :to="{name:'desk.job.info'}" class="btn btn-link btn-float has-text"><i class="icon-info22" ></i><span>Info</span></router-link> 
                        <router-link :to="{name:'desk.job.jwbs'}" class="btn btn-link btn-float has-text"><i class="icon-tree5" ></i><span>Jwbs</span></router-link> 
                        <router-link :to="{name:'desk.job.bids'}" class="btn btn-link btn-float has-text"><i class="icon-users4" ></i><span>Bids</span></router-link>
                        <a @click="editJob" class="btn btn-link btn-float has-text"><i class="icon-pencil7" ></i><span>Jobable</span></a>
                   </div>
                
                </div>
            </div>

        
        </div>
    
        <div class="content">
            <div :class="{loader:loading}"></div> 
            <router-view :class="{hidden:loading}" :info="info"></router-view>   

        </div>
        <notify :warns="$store.state.notifications"></notify>
    </div>
</template>

<script>

import bids from './job/bids';
import notify from './../../../core/Notify';
export default {
 
    data() {
        return {
            loading: true,
              id: this.$route.params.id,
              info: {
                  status: null,
                  awarded: { user: {
                        first_name: null,
                        last_name: null
                    } 
                 },
                  project: { 
                      name: null,
                      industry: {
                          name: null
                      },
                      nation: {
                          name: null
                      }
                  },                 
                  jobable: {},
                  bids: [],

              } 
        }
    },
  

    created() {       
        this.getJob();
        let _this = this;
        bus.$on('bid_success', function() {
            _this.getJob();
        })
    },
    components: {
        notify,
    },
   
    methods: {
        
        getJob() {
           
            axios.get('/api/works/'+this.id)
                 .then(({data})=>{
                     this.info = data;
                     this.$store.commit('loadItem', {label: 'Job', name: data.jobable.name});
                     this.loading = false;
                })
                 .catch((error)=>console.log(error));
        }, 
        editJob() {
              let _this = this;
              if(this.info.jobable_type == 'project') {   
                    this.$router.push({ name: 'desk.project.info', params: { pid: this.info.project.id }});
               }

              if(this.info.jobable_type == 'section') {
                    var payload = {
                        id: this.info.jobable_id,
                        name: this.info.jobable.name,
                        from_date: this.info.from_date,
                        to_date: this.info.to_date,
                        status: this.info.status,
                        description: this.info.jobable.description
                    }

            
                    this.$router.push({ name: 'desk.project.sections', params: { pid: this.info.project.id }});
                    setTimeout(function(){
                        bus.$emit('editgroup', payload)
                    
                    }, 5);
                }
                if(this.info.jobable_type == 'package'){
                    var payload = {
                        id: this.info.jobable_id
                    }
                    this.info.jobable.job = {};
                    this.info.jobable.from_date = this.info.from_date;
                    this.info.jobable.to_date = this.info.to_date;
                    this.info.jobable.status = this.info.status;
                
                    router.push({ name: 'desk.project.section.packages', params: { pid: this.info.project.id, gid: this.info.jobable.group_id }});
                
                    setTimeout(function(){bus.$emit('editpackage', _this.info.jobable)}, 1);
                }    
            


        }     
    }
}
</script>


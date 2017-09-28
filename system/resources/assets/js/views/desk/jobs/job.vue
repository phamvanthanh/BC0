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
                        <router-link :to="{name:'desk.job.info'}" class="btn btn-link btn-float has-text"><i class="icon-info22"></i><span>Info</span></router-link> 
                        <router-link :to="{name:'desk.job.jwbs'}" class="btn btn-link btn-float has-text"><i class="icon-tree5"></i><span>Jwbs</span></router-link> 
                        <router-link :to="{name:'desk.job.bids'}" class="btn btn-link btn-float has-text"><i class="icon-users4"></i><span>Bids</span></router-link>
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
    }
}
</script>


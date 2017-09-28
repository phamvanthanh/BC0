<template>

        <div class="panel panel-flat">
            <div class="panel-heading">             
                <div class="heading-elements">
                    <div class="heading-btn">
                        <div v-if="info.jobable_type == 'project'" class="form-group">
                            <div class="switch-box">												  
                                <label class="switch ">	
                                    <span class="switch-label">Edit</span>																										
                                    <input v-model="editMode" @click="editToggle"type="checkbox" name="edit" >
                                    
                                    <div class="slider"></div>
                                </label>
                            </div>
                            <div class="switch-box">													
                                <label class="switch">
                                    <span class="switch-label">Wbs</span>
                                    <input type="checkbox" @click="showWbs" v-model="isShowWbs" >
                                    <div class="slider"></div>
                                </label>	
                            </div>		
                        </div>
                    </div>
                </div>
            </div>
          
            <div class="panel-body">
                <div v-if="showJwbs"  >
                    <div :class="{loader:jwbsLoading}"></div>
                    <ul :class="{hidden:jwbsLoading}"  id="pwbs-edit-ul" class="ui-wbstree wbstree-container wbstree-plain"  >
                        
                        <jwbs										
                            :node="jwbs" 
                            :info="info">
                        </jwbs>           
                    </ul> 
                </div>
                <div v-if="info.jobable_type == 'project'">
                    <!--<div v-if="!editMode" >
                        <div :class="{loader:jwbsLoading}"></div>
                        <ul :class="{hidden:jwbsLoading}"  id="pwbs-edit-ul" class="ui-wbstree wbstree-container wbstree-plain"  >
                            <jwbs										
                                :node="jwbs" 
                                :info="info">
                            </jwbs>           
                        </ul>
                    </div>-->
                    <div v-if="editMode">                          
                        <pwbs 
                            :info="info"
                            :editMode="editMode"
                            :isShowWbs="isShowWbs"
                            >

                        </pwbs>     
                        
                    </div>    
                </div>
            </div>       
           
         
        </div>

 

</template>
<script>


import jwbs from './../../elements/pwbs'; // to display basic jwbs
import pwbs from './../projects/pwbs';

export default {
    props: ['info'],  
    data() {
        return {
            jwbsLoading: true,  
            editMode: (localStorage.getItem('jwbsedit') =="false"? false: true), 
            isShowWbs: localStorage.getItem('isShowWbs') == "false"? false: true,             
            id : this.$route.params.id,        
            jwbs: [],                
           
        }
    },

    created() {    
       
        this.getJwbs(this.id);

        console.log('It is me');
        
        
    },
    watch: {
        'job.jobable_type': function () {
               if(this.job.jobable_type =='group')        
                    this.getPackages(this.job.jobable_id);
        }         
         
    },
    computed: {
        showJwbs: {
            get() {
                if((this.info.jobable_type == 'project' && !this.editMode) || this.info.jobable_type != 'project')
                    return true;
                return false;
            },
            set() {

            }
        }
    },

    components: {    
        jwbs,
        pwbs     
    },
    methods: { 
        editToggle() {
            localStorage.setItem('jwbsedit', this.editMode);
        },
        showWbs() {
            localStorage.setItem('isShowWbs', this.isShowWbs);
        },
        getJwbs(id) {   
            this.jwbsLoading = true;      
            axios.get('/api/jobs/'+id+'/jwbs')
                 .then(({data})=>{
                     this.jwbs = data; 
                     this.jwbsLoading = false;
                    })
                 .catch((error)=>{console.log(error)});
        }, 

       
      
      
        // getJwbs(id) {    
        //      if(this.info.id)
        //     axios.get('/api/jobs/'+id+'/jwbs')
        //          .then(({data})=>{
        //              this.jwbs = data; 
        //              this.loading = false;
        //             })
        //          .catch((error)=>{console.log(error)});
        // }, 
         
        

    }


}
</script>
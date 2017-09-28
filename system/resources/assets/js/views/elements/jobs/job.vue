<template>       

<div class="panel panel-flat">
    <div class="panel-heading">
        <h6 class="panel-title"><router-link :to="{name: 'jwbs', params: {jid: jid} }">{{job.jobable.name}}</router-link></h6>
         <div>
            <span>Type: {{job.jobable_type}} | </span>
            <span>Time frame: From: {{job.from_date}} to {{job.to_date}} | </span>
            <span>Project: {{project.name}} | </span>
            <span>Status: {{job.status}} | </span>
            <span>Bids: <router-link :to="{name: 'bids', params: {jid: jid}}">  {{job.bids? job.bids.length: 0}}</router-link> </span>
        </div>
        <div class="heading-elements">
            <div class="heading-btn">
                <div class="form-group">            
                   <button v-if="bidable" @click="bid" class="btn btn-warning input-sm" > Bid</button> 
                   <router-link :to="{name:'quantity', params:{jid: jid}}" class="btn btn-success input-sm" >Report</router-link>                        
                </div>								
            </div>
        </div>
    </div>
    <div class="panel-body">      
       <router-view :job="job" ref="hot" ></router-view>
    </div>
</div>
 

</template>
<script>


import jwbs     from './../../elements/pwbs';

export default {  
    data() {
        return {               
                jid : this.$route.params.jid,               
                job: {
                    id: null,
                    jobable_type: null,
                    from_date: null,
                    to_date: null,
                    status: null,
                    jobable: {
                        name: null,
                        description: null
                    },
                    bids: []
                },
                project: {
                    name: null
                },
                form: new Form ({
                    job_id: null,
                    user_id: null
                }),
        }

    },
    created() {    
        this.getJob(this.jid);
        var _this = this;         
    },
    computed: {
        auth() {
            return this.$store.state.user;
        },
        bidable() {
            
            var isbidden = false;
            if(this.job.bids) {
                for(let index in this.job.bids) {                  
                    if(this.job.bids[index].user_id == this.auth.id) {
                        isbidden = true;
                        break;
                    } 

                }
            }
            return this.checkRoleFor(this.job.jobable_type) && !isbidden && this.job.status =='active';
        }        
    },

    components: {    
             
    },
    methods: { 

        getJob(jid) {          
            axios.get('/jobs/'+jid)
                 .then(({data})=>{              
                     this.job = data.job; 
                     this.project = data.project;})
                 .catch((error)=>{console.log(error)});
        },  
        checkRoleFor(type) {
              let checkString = '';
              switch(type) {
                case 'project':
                    checkString = 'Project Manager';
                    break;
                case 'group':
                    checkString = 'QTO Controller';                       
                    break;
                case 'package':
                    checkString = 'Surveyor'; 
                    break;
                default:
                    return false;
              }

            if(this.auth.roles.indexOf(checkString) >= 0)
                return true;
            return false;
        },
        bid() {
            // if(!this.checkRoleFor(this.job.jobable_type))
            //     return;
            this.form.user_id = this.auth.id,
            this.form.job_id = this.job.id;
            this.form.post('jobs/'+this.job.id+'/bids')
                     .then(({data})=>{
                         this.formNotify();
                         this.getJwbs(this.jid);})
                     .catch((error)=>{
                         this.formNotify()})

        },
      
        formNotify() {
            this.$store.commit('loadNotifications', this.form.notifications)
            
        }           
        

    }


}
</script>
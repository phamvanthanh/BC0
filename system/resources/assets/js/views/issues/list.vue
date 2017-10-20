<template>
<div class="panel panel-flat">
    <div :class="{loader:loading}"></div>
    <div :class="{hidden:loading}" class="panel-heading">
        <!--<h6 class="panel-title">Issues</h6>-->
        <div class="heading-elements">
            <ul class="pt-10">
                <li>  <router-link :to="{name: $route.name+'.new'}" ><button class="btn btn-success" >New Issue</button></router-link></li> 
                
            </ul>
        </div>
    </div>
    
    <div :class="{hidden:loading}" class="panel-body">
        <div id="issue-list">
            <ul class="pt-20">    
                
                <li  v-for="issue in issues"
                    :issue="issue"
                    :key="issue.id" 
                    class="list-group-item">
                    <span class="mr-5"><i :class="[issue.status=='closed'? 'text-success': 'text-warning','icon-notification2']"></i></span>
                    <span><router-link :to="{name: $route.name+'.issue', params:{iid:issue.id}}" class="fs-16" >{{issue.title}} - #{{issue.id}}</router-link></span><br>
                    <span class="text-muted pl-25" >Opened by {{issue.jobable_name}} {{issue.role}} {{issue.created_at}}</span>                
                </li>       

            </ul>
        </div>
    </div>
</div>

</template>

<script>


export default {
    // Recieves job id to get job issues

    props: ['job_id'],

    data() {
        return {
            loading: true,
            issues: []
        }
    },

    computed: {
      
    },
    created() {

        this.getIssues(this.job_id);        
    },

    watch: {
        job_id: function(val) {
             this.getIssues(val);
        }
    },
    methods: {
       
        getIssues(id) {
            if(id)
                axios.get('/api/jobs/'+id+'/issues')
                    .then(({data})=>{
                        this.issues = data.map(function(e){
                            return {
                                id: e.id,
                                title: e.title,
                                jobable_name: e.job.jobable.name,
                                status: e.status == 'closed'? 'closed' : 'open',
                                created_at: moment(e.created_at).endOf('day').fromNow(),
                                job_id: e.job_id,
                                role: e.job.jobable_type == 'package'? 'Surveyor': e.job.jobable_type == 'group'? 'Controller': (e.job.jobable_type == 'project' && e.user_id == e.job.jobable.user_id)? 'Client' : 'Project Manager'  
                               
                            }
                           
                            
                        });
                        this.loading = false;
                    })
                    .catch(({error})=>console.log(error));
        }
    }
}

</script>
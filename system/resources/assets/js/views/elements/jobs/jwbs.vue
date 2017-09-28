<template>       
<div>
    <div><span>Note: {{job.jobable.description}}</span></div>
    <div v-if="job.jobable_type == 'group'" class="table-responsive">
        <table class="table">
            <tbody>
                <tr v-for="package in packages" >
                    <td>                   
                        <router-link :to="{name:'audit', params:{jid: package.job.id}}" >{{package.name}}</router-link>
                    </td>
                    <td>
                        {{ package.area * package.complexity}}
                    </td>
                    <td>
                        {{package.description}}
                    </td>
                    <td>
                        #{{package.job.awarded != null? package.job.awarded.user_id: null }}
                    </td>
                    <td>
                        {{package.job.awarded != null? package.job.awarded.created_at: null }}
                    </td>
                    
                </tr>
            </tbody>
        </table>

    </div>
    <ul id="pwbs-edit-ul" class="ui-fancytree fancytree-container fancytree-plain" >
        <jwbs										
            :node="jwbs"                                        
            >
        </jwbs>           
    </ul>
</div>
 

</template>
<script>


import jwbs     from './../../elements/pwbs';

export default {  
    data() {
        return {               
                jid : this.$route.params.jid,        
                jwbs: [],  
                packages: []          
              
        }
    },
    props: {
        job: {
            id: null,
            jobable_id: null,
            jobable_type: null,
            from_date: null,
            to_date: null,
            status: null,
            jobable: {
                name: null,                
                description: null
            },
            
        },
    },
    created() {    
        this.getJwbs(this.jid);
        
        
    },
    watch: {

        'job.jobable_type': function () {
               if(this.job.jobable_type =='group')        
                    this.getPackages(this.job.jobable_id);
        }
         
         
    },

    components: {    
        jwbs      
    },
    methods: { 
        getJwbs(jid) {          
            axios.get('/jobs/'+jid)
                 .then(({data})=>{
                     this.jwbs = data.data; 
                    })
                 .catch((error)=>{console.log(error)});
        }, 
        getPackages(gid) {
           
            axios.get('/api/projects/groups/'+gid+'/packages')
                 .then(({data})=>{
                     console.log(data);
                     this.packages = data; 
                    })
                 .catch((error)=>{console.log(error)});
        } 
      
         
        

    }


}
</script>
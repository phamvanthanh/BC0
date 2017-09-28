 <template>
    <div class="content-wrapper">
        <div class="page-header">
            <div class="page-header-content">
                <div class="page-title">
                  <window-heading2></window-heading2>                  
                </div>

                <div class="heading-elements">
                    <div class="heading-btn-group" >
                        <router-link :to="{name:'desk.client.info'}" class="btn btn-link btn-float has-text"><i class="icon-info22"></i><span>Info</span></router-link> 
                        <router-link :to="{name:'desk.client.projects'}" class="btn btn-link btn-float has-text"><i class="icon-tree5"></i><span>Projects</span></router-link> 

                    </div>
                
                
                </div>
            </div>   
        </div>

        <div class="content">
            <div :class="{loader:loading}"></div>
             
           <router-view 
                :class="{hidden:loading}"
                :client="client">
           </router-view>
        </div>
    </div>
</template>
<script>
    export default {
        data() {
            return {    
                loading: true,
                uid: this.$route.params.uid,           
                client:{},               
            }
        },
      
        created() {           
            this.getClient(this.uid);           
        },     
   
        methods: {    
            getClient(uid) {
                axios.get('/api/desk/clients/'+uid)
                     .then(({data})=>{
                        this.client = data;
                        this.$store.commit('loadItem', {label: 'Client', name: data.first_name+' '+data.last_name});
                        this.loading = false;
                        })
                     .catch((error)=>{
                         console.log(error);})
            },           
          
        }
      
    }
</script>
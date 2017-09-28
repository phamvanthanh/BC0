 <template>
<div class="content-wrapper">
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <window-heading2></window-heading2>              
            </div>
            <div class="heading-elements">
               
            </div>
        </div>    
    </div>
    <div class="content">
        <div :class="{loader:loading}"></div>
        <router-view 
            :class="{hidden:loading}"
            name="info" 
            :info="info" >
            <button  slot="buttons"  class="btn btn-success">Bid</button>
        </router-view>
        <router-view  name="jwbs" :info="info" >
            <h6 slot="jwbs-title" class="panel-title">Jwbs</h6>    
        </router-view> 
        <notify :warns="$store.state.notifications"></notify>    
    </div>
</div>
</template>
<script>
import notify from './../../core/Notify';
// import {capitalize} from './../../core/filters';
 
export default {
    props: ['user'],
    components: {
        notify
    },
    data() {
        return {
            loading: true,
              id: this.$route.params.id,
              info: {
                  status: null,
                  awarded: { },
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
                  bids: []
              } 
        }
    },

    created() {       
        this.getJob();
    },
   
    methods: {
        
        getJob() {
           
            axios.get('/api/works/'+this.id)
                 .then(({data})=>{
                            data.from_date = data.from_date;
                            data.to_date = data.to_date;
                            data.jobable_type = data.jobable_type;
                            data.status = data.status
                            this.info = data;
                            this.loading = false;
                            // this.$store.commit('loadItem', {label:capitalize(data.jobable_type), name: data.jobable.name});
                 })
                 .catch((error)=>console.log(error));
        },
   

    }
    


}
    

</script>
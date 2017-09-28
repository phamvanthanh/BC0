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
            <div :class="{hidden:loading}" class="panel panel-flat">
                <div class="panel-heading">
            
                    <div class="heading-elements">
                        <div class="heading-btn">
                                                        
                        </div>
                    </div>
                </div>        
                <div class="panel-body">                   
                    <v-client-table 
                        :data="clients" 
                        :columns="columns" 
                        :options="options">
                        
                        <template slot="actions" scope="props">
                        
                                <router-link :to="{name: 'desk.client', params: {uid: props.row.id}}" ><i class="icon-unfold"></i></router-link>
                          
                        </template>
               
                    </v-client-table>
                    
                </div>
            </div>  
        </div>
    </div>
</template>
<script>
import  ClientTable from 'vue-tables-2';


    export default {
        data() {
            return {
                loading: true,               
                clients:[],                  
                columns: ['id', 'full_name', 'email', 'phone',  'organization', 'status', 'actions'],
                options: {
                    headings: {
                        id: 'Id',
                        full_name: 'Name',
                        actions: ''
                        
                    },
                    templates: {              
                        status: 'status'
                        
                    },
                    skin: 'table-hover',
                    texts: {
                        filter: ''
                    },
                    columnsClasses: {                           
                       
                        id: 'w-70',
                        full_name: 'column-expanded',
                        nation: 'w-70',                        
                        email: 'w-200',
                        phone: 'w-125',
                        organization: 'w-200',
                        status: 'w-70', 
                        actions: 'text-right w-40 action'                
                    },
                    sortIcon: { 
                        base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'

                    },


                }                     
                
            }
        },
      
        created() {
            let _this = this;
            this.getClients();
           
        }, 

        methods: {   
  
            getClients() {
                axios.get('/api/desk/clients')
                     .then(({data})=>{
                         this.clients = data.map(function(e){
                             e.full_name = e.first_name + ' ' + e.last_name;
                             e.status = e.status == 1? 'active': 'deactive';
                             return e;
                         });
                         this.loading = false;
                    })
                     .catch((error)=>{
                         console.log(error);})
            },
            
        }
      
    }
</script>
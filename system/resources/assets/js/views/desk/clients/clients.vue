 <template>
    <div class="content-wrapper">
        <div class="page-header">
            <div class="page-header-content">
                <div class="page-title">
                    <page-label></page-label>
                </div>
                <div class="heading-elements">
                
                </div>
            </div>   
        </div>

        <div class="content">         
            <div  class="panel panel-flat">
                <div class="panel-heading">
            
                    <div class="heading-elements">
                        <div class="heading-btn">
                                                        
                        </div>
                    </div>
                </div>        
                <div class="panel-body">                   
                    <v-server-table 
                        url="/api/desk/clients" 
                        :columns="columns" 
                        :options="options">
                         <template slot="name" scope="props">
                             {{props.row.first_name}} {{props.row.last_name}}                          
                        </template>
                        <template slot="actions" scope="props">                        
                                <router-link :to="{name: 'desk.client', params: {uid: props.row.id}}"  class="text-primary" ><i class="icon-unfold"></i></router-link>
                        </template>
               
                    </v-server-table>
                    
                </div>
            </div>  
        </div>
    </div>
</template>
<script>

    export default {
        data() {
            return {
                loading: true,               
                clients:[],                  
                columns: ['id', 'name', 'email', 'phone',  'organization', 'nation_abbr', 'active', 'actions'],
                options: {
                    headings: {
                        nation_abbr: 'Nation',                 
                        actions: ''
                        
                    },
                    templates: {              
                        status: 'active'
                        
                    },
               
                    columnsClasses: {                           
                       
                        id: 'w-70',
                        name: 'column-expanded',
                        nation_abbr: 'w-70',                        
                        email: 'w-300',
                        phone: 'w-125',
                        organization: 'w-200',
                        active: 'w-70', 
                        actions: 'text-right w-40 action'                
                    },
                    sortable: ['id', 'name', 'email', 'phone', 'organization', 'nation_abbr', 'status'],


                }                     
                
            }
        },
      
        created() {
            // let _this = this;
            // this.getClients();
           
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
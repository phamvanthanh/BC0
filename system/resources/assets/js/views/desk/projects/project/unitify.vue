<template  >
    <div class="panel panel-flat">
        <div :class="{loader:loading}"></div>
        <div :class="{hidden:loading}" class="panel-heading">
         
            <div class="heading-elements">
                <ul class="icons-list">
                    
                    
                </ul>
            </div>
        </div>
        
        <div :class="{hidden:loading}"  class="panel-body">
           
                <div class="search-input form-group " >
                        <input id="search_field" type="search" class="form-control" v-model="searchString" @keyup="search" placeholder="Search">
                </div>
                <div  v-if="leaves.length > 0" id="hot-preview">
                    <HotTable ref="hot"
                            :root="root" 
                            :settings="hotSettings"
                            :data="leaves" >
                    </HotTable>
                </div>
           
                <div v-else>                
                    <div class="table-norecord">
                        <span>No records.</span>
                    </div>                
                </div>
                
        </div>
        
        
        
    </div>



</template>

<script>
   
  import moment from 'moment';
  import numbro from 'numbro';
  import pikaday from 'pikaday';
  import Zeroclipboard from 'zeroclipboard';
  import Handsontable from 'handsontable';
  import HotTable from 'vue-handsontable-official';

    
    export default {
        props: ['info', 'job'],
        data() {
              
            return {
                loading: true,
                searchString: '',
                leaves:  [],
                root: 'unitify',
                hotSettings: {
                  startCols: 3,           
                  rowHeaders: true,
                  search: true,
                  columns: [
                         
                          {data: 'code', readOnly: true, colWidths: '100px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                               return document.getElementById('hot-preview').offsetWidth - 225;
                          }},
                         
                          {data: 'unit', type: 'dropdown', colWidths: '60px',                             
                              source: ['m', 'm2', 'm3', 'kg', 'ton', 'ea', 'set', 'lot'],
                              strict: true,
                              allowInvalid: true
                          }
                       
                  ],
                  className: "htLeft",
                  colHeaders: ['Code', 'Name', 'Unit'],
               
                  afterChange: function(change, source) {
                      if(source == 'edit') {
                          var change = change[0], data;             
                          var row  = this.getSourceDataAtRow(change[0]);
                          if(change[2] != row.unit){
                        
                              var form = new Form({
                                    project_id: row.project_id,
                                  code      : row.code,
                                  unit      : row.unit
                              });              
                             
                              form.post('/api/projects/'+row.project_id+'/pwbs/unitify')
                                    .then(({data})=>{
                                        notice(form.notifications, 5000);
                                        form.reset();
                                    })
                                    .catch((error)=>{
                                        notice(form.notifications, 5000);
                                        bus.$emit('refreshleave')
                                        form.reset();

                                    })
                              
                          }
                           

                      }
                      
                  }
                }
            }          
        
        },
        computed: {
            pid: {
                get() {
                    if(this.job)
                        return this.job.jobable_id;
                    else if(this.info)
                        return this.info.jobable_id; 
                }
            }
        },
        created() {
             this.getLeaves(this.pid); 
             bus.$on('refreshleave', ()=>{
                 this.getLeaves(this.pid);
             })
        },
        watch: {
            'info.jobable_id': function(val) {
                 this.getLeaves(val);   
            }
        },      
  
       
        components: {          
         
            HotTable                   
           
                      
        },
        methods: {
            getLeaves(id) {
                if(id)
                 axios.get('/api/projects/'+id+'/pwbs/leaves')
                 .then(({data})=>{
                   if(data.length > 0)        
                        this.leaves = data;
                   else
                        this.leaves = [];
                   this.loading = false;
                  })
                 .catch((error)=>{
                   console.log(error)})    

            },
            search() {    
                var queryResult = this.$refs.hot.table.search.query(this.searchString);                
                this.$refs.hot.table.render();              
  
            }
        }
      
    }
</script>


<style>

</style>



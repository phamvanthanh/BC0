<template>
<div  class="wrapper">
    <HotTable :root="root" 
                :settings="hotSettings"
                :data="leaves"
                
                 >
    </HotTable>
     <modal v-if="showModal" 
            :id="quantityId" 
            :fileType="fileType"
            :fileFormat="fileFormat"
            @close="showModal = false"
            :uploadUrl="uploadUrl">
  
      
    </modal>

</div>

</template>
<script>
import moment from 'moment';
import numbro from 'numbro';
import pikaday from 'pikaday';
import Zeroclipboard from 'zeroclipboard';
import HotTable from 'vue-handsontable-official';
import modal from './uploadModal';

    
    export default {
        data() {
              
            return {
                quantityId: '',
                fileType: '',
                fileFormat: '',
                uploadUrl: null, 
                jid: this.$route.params.jid,
                showModal: false,
                leaves:  null,
                root: 'unitify',
                hotSettings: {
                  startCols: 7,           
                  rowHeaders: true,
                  allowInsertRow: true,
                
                  rowHeaders: true,
                  copyPaste: true,
                  copyable: true,
                  copyRowsLimit: 1000,
                  columns: [
                         
                          {data: 'code', readOnly: true},
                          {data: 'name', readOnly: true},
                          {data: 'quantity'},
                          {data: 'unit', readOnly: true },
                          {data: 'file'},
                          {data: 'markdown'},
                          {data: 'commit', type: 'checkbox'},
                  ],
                  colHeaders: ['Code', 'Name', 'Quantity', 'Unit', 'File', 'Markdown', 'Cm'],
                  stretchH: 'all',
                  afterChange: function(change, source) {                      
                      if(source == 'edit') {
                          var change = change[0], data;             
                          var row  = this.getSourceDataAtRow(change[0]);
                          console.log(row);
                         if(change[2] != change[3])
                         {
                              
                              data = {
                                  id        : row.id,
                                  job_id    : row.job_id==null? jid: row.job_id,
                                  code      : row.code,
                                  quantity  : row.quantity,
                                  commit    : row.commit
                              }
                              axios.post('/jobs/'+jid+'/quantity', data)
                                    .then(({data}))
                                    .catch((error)=>console.log(error))                              
                          }
                      }                      
                  },
                  afterBeginEditing: function(row, col) {
                     
                      if(col == 4 || col == 5) {
                           var rowData  = this.getSourceDataAtRow(row); 
                           console.log(rowData);
                           if(rowData.id == null) {
                               alert('You must fill quantity before uploading file');
                               return;
                           }   
                           let type =  col == 4? 'quantity': 'markdown'; 
                           let format  = col ==4? 'application/.xls,.xlsx' : 'image/*,application/pdf';
                           let uploadUrl='/jobs/'+jid+'/quantity/files';
                           let payload = {format: format, type: type, quantityId: rowData.id, uploadUrl: uploadUrl};
                           bus.$emit('showUploadModal', payload);      

                      }
                                  
                  },
                }
            }          
        
        },
        created() {
            let _this = this;
            this.getData();
            window.jid = this.$route.params.jid;

            bus.$on('showUploadModal', function(payload) {                
                _this.quantityId = payload.quantityId.toString();
                _this.fileType = payload.type;
                _this.fileFormat = payload.format;
                _this.showModal = true;
                _this.uploadUrl = payload.uploadUrl;
            });
            bus.$on('refreshtable', function() {
                _this.getData();
                _this.showModal = false;
            })

        },       
            
        computed: {
            notifications() {
                return this.$store.state.notifications
            }, 
                    
        },
       
        components: {         
            HotTable,
            modal          
                      
        },
        methods: {
            getData() {
                axios.get('/jobs/'+this.jid+'/quantity')
                 .then(({data})=>{        
                   this.leaves = data;})
                 .catch((error)=>{
                   console.log(error)});               
            }

        }
      
    }
</script>



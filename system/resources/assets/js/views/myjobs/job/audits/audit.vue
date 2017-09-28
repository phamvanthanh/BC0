<template>
<div class="panel panel-flat">
    <div class="panel-heading">
        <h6 class="panel-title">Job No: {{sid}}</h6>
        <div class="heading-elements">
            <ul class="icons-list">
                
                
            </ul>
        </div>
    </div>
    
    <div class="panel-body">
        <div id="hot-preview"  >
            <HotTable :root="root" 
                    :settings="hotSettings"
                    :data="leaves"                          
                        >
            </HotTable>

            <modal v-if="showModal" 
                    :id="id"           
                    :job_id="info.id" 
                    :quantity_id="quantity_id"
                    :code="code"
                    :fileType="fileType"
                    :fileFormat="fileFormat"
                    @close="showModal = false"
                    :uploadUrl="uploadUrl">            
                
                    <input slot="quantity_id" type="hidden" :value="quantity_id" name="quantity_id">
                
            </modal>
        </div>
    </div>
</div>

</template>
<script>
import moment from 'moment';
import numbro from 'numbro';
import pikaday from 'pikaday';
import Zeroclipboard from 'zeroclipboard';

import HotTable from 'vue-handsontable-official';
import Handsontable from 'handsontable';
import modal from './../uploadModal';



function QLink(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.file)
    {
        escaped = '<a href="/api/downloads/jobs/qfiles/'+rowData.job_id+'/'+rowData.code+'" download targer="_blank" ><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><a><i><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
}

function Mrkd(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.markdown)
    {
        escaped = '<a href="/api/downloads/jobs/mrkd/'+rowData.job_id+'/'+rowData.code+'" download targer="_blank" ><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><a><i><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

function ALink(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.a_file)
    {
        escaped = '<a href="/api/downloads/jobs/afiles/'+rowData.job_id+'/'+rowData.code+'" download targer="_blank" ><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><a><i><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

function Amrkd(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.a_markdown)
    {
        escaped = '<a href="/api/downloads/jobs/amrkd/'+rowData.job_id+'/'+rowData.code+'" download targer="_blank" ><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><i><a><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

    
    export default {
        
        props: {
            info: null
        },
        data() {
              
            return {
                sid: this.$route.params.sid, // sub job id (audit job)
                quantity_id: null, 
                uploadUrl: null,
                showModal: false,
                leaves:  null,
                root: 'audit',
                
                hotSettings: {
                  startCols: 12,           
                  rowHeaders: true,            
                  className: "htLeft",
                  autoColumnSize: true,
                //   stretchH: 'all',
                  columns: [
                         
                          {data: 'code', readOnly: true, colWidths: '60px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                              return document.getElementById('hot-preview').offsetWidth - 655;}
                          },
                          {data: 'quantity', readOnly: true, type: 'numeric', format: '0.00', colWidths: '90px'},
                          {data: 'unit', readOnly: true, colWidths: '45px' },   
                          {data: 'file',  readOnly: true, renderer: QLink, colWidths: '45px'},
                          {data: 'markdown', readOnly: true, renderer: Mrkd, colWidths: '45px'},                      
                          {data: 'commit', type: 'checkbox', readOnly: true, colWidths: '40px'},
                          {data: 'a_quantity', readOnly: true, type: 'numeric', format: '0.000', colWidths: '90px'}, 
                          {data: 'defer', type: 'numeric', format: '00.00 %', readOnly: true, colWidths: '60px'},                                              
                          {data: 'a_file', renderer: ALink, colWidths: '45px' },
                          {data: 'a_markdown', renderer: Amrkd, colWidths: '45px'},
                          {data: 'a_commit', type: 'checkbox', colWidths: '40px'},

                  ],
                 
                  colHeaders: ['Code', 'Name', 'Quantity', 'Unit', 'File', 'Mrk', 'Cmt', 'Adt Quantity', 'Defer',  'AFile', 'AMrk', 'ACmt'],
                  
                  afterChange: function(change, source) {                      
                      if(source == 'edit') {
       
                          var change = change[0], data;   
                          if(change[1] == 'a_quantity' || change[1] == 'a_commit'){
                              var rowData  = this.getSourceDataAtRow(change[0]);
                            
                               if(!rowData['id']) {
                                   alert('Please submit quantity before commiting.');

                                   return false;
                               }
                                   
                               if(change[2] != change[3]) {
                                    
                                    data = {                    
                                    
                                        id      : rowData.id,                                    
                                        commit    : rowData.a_commit
                                    }
                                    axios.post('/api/jobs/'+jid+'/audit', data)
                                            .then(({data}))
                                            .catch((error)=>console.log(error))                              
                                }
                          }                        
                      }                      
                  },
                  afterBeginEditing: function(row, col) {
                      if(col == 9 || col == 10) {
                           var rowData  = this.getSourceDataAtRow(row);                          
                    
                           let type =  col == 9? 'quantity': 'markdown'; 
                           let format  = type =='quantity'? 'application/.xls,.xlsx,.csv' : 'image/*,application/pdf';
                          
                           let payload = {format: format, type: type, code: rowData.code, id: rowData.id, quantity_id: rowData.quantity_id, audit_id: rowData.audit_id};
                           bus.$emit('showUploadModal', payload);   

                      }                 
                  },
                }
            }          
        
        },
        created() {
            let _this = this;
            this.getData();
           
            window.jid = this.sid;
            this.uploadUrl  = '/api/jobs/'+this.sid+'/audit/files';
            
            bus.$on('showUploadModal', function(payload) {    
                _this.id          = payload.id;
                _this.quantity_id = payload.quantity_id;
                _this.code        = payload.code;
                _this.fileType    = payload.type;
                _this.fileFormat  = payload.format;
                _this.showModal   = true;
              // _this.uploadUrl = '/jobs/'+this.sid+'/audit/files';  
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
        watch: {
            'info.id': function() {
                window.jid = this.sid;
                // this.uploadUrl = '/jobs/'+this.sid+'/audit/files';  
                this.getData();
                
            }
        },
        components: {    
         
            HotTable,
            modal      
                      
        },
        methods: {
            getData() {
                 if(this.info.id)
                 axios.get('/api/jobs/'+this.sid+'/audit')
                 .then(({data})=>{        
                   this.leaves = data.map(function(e){
                       if(e.commit == 1)
                         e.commit = true;
                       else 
                         e.commit = false;

                        if(e.a_commit == 1)
                         e.a_commit = true;
                       else 
                         e.a_commit = false;

                       return e;
                   });})
                 .catch((error)=>{
                   console.log(error)});
               
            }

           
        }
      
    }
</script>



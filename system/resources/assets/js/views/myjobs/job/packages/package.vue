<template>
<div class="panel panel-flat">
    <div :class="{loader:loading}"></div>
    <div :class="{hidden:loading}" class="panel-heading">
        
        <div class="heading-elements">
            <ul class="icons-list">
                
                
            </ul>
        </div>
    </div>
    
    <div :class="{hidden:loading}" class="panel-body">
        <div class="search-input form-group " >
            <input id="search_field" type="search" class="form-control" v-model="searchString" @keyup="search" placeholder="Search">
            
        </div>
        <div id="hot-preview"  >
            <HotTable ref="hot"
                    :root="root" 
                    :settings="hotSettings"
                    :data="leaves"                          
                        >
            </HotTable>
           
            <input name="fileUpload" @change="onFileChange" id="file-input" class="chat-actions hidden" type="file" >

        </div>
    </div>
</div>

</template>
<script>

// import numbro from 'numbro';
// import pikaday from 'pikaday';
// import Zeroclipboard from 'zeroclipboard';

import HotTable from 'vue-handsontable-official';
import Handsontable from 'handsontable';




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
        escaped = '<a href="/api/downloads/jobs/amrkd/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><i><a><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

    
    export default {
        ref:"pkq",
        props: {
            info: null
        },
        data() {
              
            return {
                loading: true,
                sid: this.$route.params.sid, // sub job id (audit job)
                searchString: '',
                quantity_id: null, 
                uploadUrl: null,
                showModal: false,
                leaves:  null,
                root: 'audit',
                form: new Form({
                    id: null,
                    job_id: this.info.id,
                    quantity_id: null,
                    code: null,
                    fileType: null,
                    fileFormat: null,
                    
                }),
                
                hotSettings: {
                  startCols: 12,           
                  rowHeaders: true,            
                  className: "htLeft",
                  autoColumnSize: true,
                  search: true,
                  fillHandle: {
                    autoInsertRow: false,
                  },
                  columns: [
                         
                          {data: 'code', readOnly: true, colWidths: '80px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                              return document.getElementById('hot-preview').offsetWidth - 685;}
                          },
                          {data: 'quantity', readOnly: true, type: 'numeric', format: '0.00', colWidths: '90px'},
                          {data: 'unit', readOnly: true, colWidths: '45px' },   
                          {data: 'file',  readOnly: true, renderer: QLink, colWidths: '45px'},
                          {data: 'markdown', readOnly: true, renderer: Mrkd, colWidths: '45px'},                      
                          {data: 'commit', type: 'checkbox', readOnly: true, colWidths: '40px'},
                          {data: 'a_quantity', readOnly: true, type: 'numeric', format: '0.00', colWidths: '90px'}, 
                          {data: 'defer', type: 'numeric', format: '00.00 %', readOnly: true, colWidths: '70px'},                                              
                          {data: 'a_file', renderer: ALink, colWidths: '45px' },
                          {data: 'a_markdown', renderer: Amrkd, colWidths: '45px'},
                          {data: 'a_commit', type: 'checkbox', colWidths: '40px'},

                  ],
                 
                  colHeaders: ['Code', 'Name', 'Quantity', 'Unit', 'File', 'Mrk.', 'Cmt', 'C.Quantity', 'Defer',  'CFile', 'CMrk.', 'CCmt.'],
                  
                  afterChange: function(change, source) {                      
                      if(source == 'edit') {
       
                          var change = change[0], data;   
                          if(change[1] == 'a_commit'){
                              var rowData  = this.getSourceDataAtRow(change[0]);
                                if(change[2] != change[3]) {
                                    if(!rowData['id']) {                                        
                                        notice({status: 422, data: ['Surveyor commit is not available']}, 6000);
                                                setTimeout(()=>{
                                                    this.setDataAtCell(change[0], 11, false)}, 1);
                                        return false;
                                    }                                  
                     
                                    
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
                      var rowData  = this.getSourceDataAtRow(row);
                    
                      if(!rowData.commit) {
                          notice({status: 422, data: ['Surveyor commit is not available']}, 6000);
                          this.destroyEditor();
                          return false;
                      }
                      if(col == 9 || col == 10) {
                           var rowData  = this.getSourceDataAtRow(row);                          
                    
                           let type =  col == 9? 'quantity': 'markdown'; 
                           let format  = type =='quantity'? 'xls,xlsx,csv' : 'pdf,png,gif,jpg';
                     
                           let payload = {format: format, type: type, code: rowData.code, id: rowData.id, quantity_id: rowData.quantity_id, audit_id: rowData.audit_id};
                           bus.$emit('loadform', payload);   
                           this.destroyEditor();
                           
                      }                 
                  },
                }
            }          
        
        },
        mounted() {
         
            this.getData();
           
            window.jid = this.sid;
            this.uploadUrl  = '/api/jobs/'+this.sid+'/audit/files';
            
            bus.$on('loadform', (payload) => {  
               
                this.form.id          = payload.id;
                this.form.quantity_id = payload.quantity_id;
                this.form.code        = payload.code;
                this.form.fileType    = payload.type;
                this.form.fileFormat  = payload.format;
                // _this.showModal   = true;
                this.uploadFile();
              // _this.uploadUrl = '/jobs/'+this.sid+'/audit/files';  
            });
             bus.$on('refreshtable', ()=>{
                this.getData();
               
            })

        },       
            
   
        watch: {
            // 'info.id': function() {
            //     window.jid = this.sid;
            
            //     this.getData();
                
            // }
        },
        destroyed() {
            bus.$off();
        },
        components: {    
         
            HotTable,
                 
                      
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
                   });
                   this.loading = false;
                })
                 .catch((error)=>{
                   console.log(error)});
               
            },
            search() {    
                var queryResult = this.$refs.hot.table.search.query(this.searchString);                
                this.$refs.hot.table.render(); 
            },
            onFileChange(e){
                let files = e.target.files || e.dataTransfer.files

                if (!files.length) {
                    return
                };
                
			    this.file = files[0];
                var extension = this.file.name.split('.').pop();
             
                if(this.form.fileFormat.indexOf(extension) < 0 ){
                    notice({status: 400, data:['File format is not accepted']}, 6000);
                    return;
                }
          
			    let formData = new FormData()
			    formData.append('file', this.file);
                formData.append('id', this.form.id);
                formData.append('job_id', this.form.job_id);
                formData.append('quantity_id', this.form.quantity_id);
                formData.append('code', this.form.code);
                formData.append('file_type', this.form.fileType);   
               
			    axios.post('/api/jobs/'+this.sid+'/audit/files', formData)
				.then((data)=>{
                    $("#file-input").val('');
                    this.getData();
					notice({status:data.status, statusText:data.statusText, data:data.data}, 6000);

				})
				.catch((error)=>{
                     $("#file-input").val('');
                    notice({status:error.response.status, data: error.response.data, statusText: error.response.statusText}, 6000);
				})     
             
            },
            uploadFile() {                
                $("#file-input").click();
               
            },

           
        }
      
    }
</script>



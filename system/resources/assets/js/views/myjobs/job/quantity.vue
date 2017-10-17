<template>
    <div class="panel panel-flat">
        <div class="panel-heading">
  
            <div class="heading-elements">
                <ul class="icons-list">
                    
                    
                </ul>
            </div>
        </div>
        
        <div class="panel-body">
            <div v-if="leaves.length > 0" >
                <div class="search-input form-group " >
                    <input id="search_field" type="search" class="form-control" v-model="searchString" @keyup="search" placeholder="Search">
                </div>
                <div  id="hot-preview" v-if="info" >
                    <HotTable ref="hot"
                            :root="root" 
                            :settings="hotSettings"
                            :data="leaves"                
                                >
                    </HotTable>
                    <input name="fileUpload" @change="onFileChange" id="file-input" class="chat-actions hidden" type="file" >
                
                </div>
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

import HotTable from 'vue-handsontable-official';
import Handsontable from 'handsontable';

function QLink(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.file)
    {
        escaped = '<a href="/api/downloads/jobs/qfiles/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download ><i class="icon-download10" ></i></a>';       
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
        escaped = '<a href="/api/downloads/jobs/mrkd/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" ><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><a><i><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

    
    export default {
        props: ['info'],
        data() {              
            return {
                searchString: '',
                quantityId: '',
                fileType: '',
                fileFormat: '',
                uploadUrl: null, 
                code: null,
                showModal: false,
                leaves:  [],
                root: 'quantity',

                form: new Form({
                    id: null,
                    job_id: this.info.id,
                    quantity_id: null,
                    code: null,
                    fileType: null,
                    fileFormat: null,
                    
                }),

                hotSettings: {
                  startCols: 7,                               
                  className: "htLeft",
                  rowHeaders: true,
                  autoColumnSize: true,
                //   stretchH: 'all',
                  search: true,
                  columns: [
                                               
                          {data: 'code', readOnly: true, colWidths: '100px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                               return document.getElementById('hot-preview').offsetWidth - 405;
                          }},
                          {data: 'quantity', readOnly: true, colWidths: '80px'},
                          {data: 'unit', readOnly: true, colWidths: '45px' },
                          {data: 'file', renderer: QLink, colWidths: '45px'},
                          {data: 'markdown', renderer: Mrkd, colWidths: '45px'},
                          {data: 'commit', type: 'checkbox', colWidths: '40px'},
                  ],
                  colHeaders: ['Code', 'Name', 'Quantity', 'Unit', 'File', 'Mrk.', 'Cmt'],
              
                  afterChange: function(change, source) {                      
                      if(source == 'edit') {
                          var change = change[0], data;   
                          if(change[1] == 'commit') {

                                var row  = this.getSourceDataAtRow(change[0]);
                                
                                if(change[2] != change[3])
                                {
                                   
                                    if(row.file == null || row.quantity == null || row.markdown == null) {
                                         notice({status: 422, data: ['Quantity or markdown file is not available']}, 6000);
                                                setTimeout(()=>{
                                                    this.setDataAtCell(change[0], 6, false)}, 1);
                                        return false;

                                    }  

                                    data = {
                                        id        : row.id,
                                        job_id    : row.job_id==null? jid: row.job_id,
                                        code      : row.code,                             
                                        commit    : row.commit
                                    }
                                    axios.post('/api/jobs/'+jid+'/quantity', data)
                                            .then(({data})=>{
                                                bus.$emit('refreshtable');
                                            })
                                            .catch((error)=>console.log(error))                              
                                }
                          } 
                      }                      
                  },
                  afterBeginEditing: function(row, col) {
                     
                      if(col == 4 || col == 5) {
                          
                           var rowData  = this.getSourceDataAtRow(row);                           
                
                           let type =  col == 4? 'quantity': 'markdown'; 
                           let format  = col == 4? 'xls,xlsx,csv' : 'pdf,png,gif,jpg';
                         
                           let payload = {format: format, type: type, quantity_id: rowData.id, code: rowData.code};
                           
                           bus.$emit('loadform', payload);  
                           this.destroyEditor();    

                      }
                                  
                  },
                }
            }        
        },
       
        mounted() {
           
            this.getData();
            this.uploadUrl='/api/jobs/'+this.info.id+'/quantity/files';
            window.jid = this.info.id;
            bus.$on('loadform', (payload)=> {                
              
                this.form.id          = payload.quantity_id;
                this.form.code        = payload.code;
                this.form.fileType    = payload.type;
                this.form.fileFormat  = payload.format;               
                this.uploadFile();

            
            });
            bus.$on('refreshtable', ()=>{
                this.getData();
                this.showModal = false;
            })

        },     
        watch: {
            // 'info.id': function() {
            //     this.getData();
            //     this.uploadUrl='/api/jobs/'+this.info.id+'/quantity/files';
            //     window.jid = this.info.id;
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
                axios.get('/api/jobs/'+this.info.id+'/quantity')
                 .then(({data})=>{        
                   this.leaves = data.map(function(e){
                        e.commit = e.commit == 1? true: false;
                        return e; 
                   });})
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
                    var accepted_format = ''
                    if(this.form.fileType == 'quantity') {
                        accepted_format = ' File format must be.xlsx or .xls.';
                    } 
                    else 
                       accepted_format = ' File format must be .pdf, .png, .gif or .jpg.';

                    notice({status: 400, data:['File format is not accepted.'+ accepted_format]}, 6000);
                    return;
                }
          
			    let formData = new FormData()
                formData.append('id', this.form.id);
			    formData.append('file', this.file);
                formData.append('job_id', this.form.job_id);               
                formData.append('code', this.form.code);
                formData.append('file_type', this.form.fileType);   
               
			    axios.post('/api/jobs/'+this.info.id+'/quantity/files', formData)
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



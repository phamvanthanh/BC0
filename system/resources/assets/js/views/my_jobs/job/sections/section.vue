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

    if(rowData.combined_file)
    {
        escaped = '<a href="/api/downloads/jobs/qfiles/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><i><a><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

function ALink(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.combined_a_file)
    {
        escaped = '<a href="/api/downloads/jobs/afiles/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><i><a><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

function Mrkd(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.combined_markdowns)
    {
        escaped = '<a href="/api/downloads/jobs/mrkd/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><i><a><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

function Amrkd(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.combined_a_markdowns)
    {
        escaped = '<a href="/api/downloads/jobs/amrkd/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><i><a><big>'); 
        td.innerHTML = escaped;
        return td;       
    }
    return '';
} 

    
    export default {
        ref:"sec",
         
        components: {  
         
            HotTable,              
                      
        },
        data() {
              
            return {
                loading: true,
                jid1: this.$route.params.jid1, // second job id (audit job)
                searchString: '',
                quantity_id: null, 
                uploadUrl: null,
                showModal: false,
                leaves:  null,
                root: 'audit',
                form: new Form({
                    id: null,
                    job_id: this.$route.params.jid1,
                    quantity_id: null,
                    code: null,
                                  
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
                         
                          {data: 'code', readOnly: true, colWidths: '60px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                              return document.getElementById('hot-preview').offsetWidth - 715;}
                          },
                          {data: 'unit', readOnly: true, colWidths: '45px' },
                          {data: 'quantity', readOnly: true, type: 'numeric', format: '0.00', colWidths: '90px'},                             
                          {data: 'file',  readOnly: true, renderer: QLink, colWidths: '45px'},
                          {data: 'markdown', readOnly: true, renderer: Mrkd, colWidths: '45px'},                      
                          {data: 'commit', type: 'checkbox', readOnly: true, colWidths: '40px'},
                          {data: 'a_quantity', readOnly: true, type: 'numeric', format: '0.000', colWidths: '90px'}, 
                          {data: 'defer', type: 'numeric', format: '00.00 %', readOnly: true, colWidths: '80px'},                                              
                          {data: 'a_file', renderer: ALink, colWidths: '45px' },
                          {data: 'a_markdown', renderer: Amrkd, colWidths: '45px'},
                          {data: 'a_commit', type: 'checkbox', readOnly:true, colWidths: '40px'},
                          {data: 'p_commit', type: 'checkbox', colWidths: '40px'},

                  ],
                 
                  colHeaders: ['Code', 'Name', 'Unit', 'Quantity', 'File', 'Mrk.', 'Cmt.', 'CQuantity', 'Defer',  'CFile', 'CMrk.', 'CCmt.', 'PCmt.'],
                  
                  afterChange: function(change, source) { 
                      if(change) 
                      if(source == 'edit') {       
                          var change = change[0], data; 
                           
                          if(change[1] == 'p_commit'){
                             
                              var rowData  = this.getSourceDataAtRow(change[0]);
                             
                               if(change[2] != change[3]){
                                    if(!(rowData['a_commit'] && rowData['commit'])) {   
                                        notice({status: 422, data: ['Surveyor or/and Controller commits are not available']}, 6000);
                                        setTimeout(()=>{
                                            this.setDataAtCell(change[0], 12, false)}, 1);
                                        return true;
                                    } 
                                                                    
                                    var form = new Form({
                                        project_id: rowData.project_id,
                                        code: rowData.code,                                                                         
                                        commit    : rowData.a_commit
                                    });

                                    form.post('/api/projects/pwbs/commit')
                                        .then((data)=>{
                                            notice(form.notifications, 6000);
                                        })
                                        .catch((error)=>{
                                            notice(form.notifications, 6000);
                                        })
                            
                                    return;
      
                               }                        
                              
                          }                        
                      }                                           
                  },               
                }
            }       
        },
        created() {
            let _this = this;
            this.getData(); 
    
            bus.$on('refreshtable', function() {
                _this.getData();
               
            })

        },       
  

        methods: {
            getData() {
      
                 axios.get('/api/jobs/'+this.jid1+'/quantity')
                 .then(({data})=>{        
                   this.leaves = data.map(function(e){                    
                        e.commit = e.commit == 1? true: false;
                        e.a_commit = e.a_commit == 1? true: false;
                        e.p_commit = e.p_commit == 1? true: false;

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
         
                     
        }
      
    }
</script>



<template>
    <div class="panel panel-flat">
        <div class="panel-heading">
          
            <div class="heading-elements">
                <ul class="icons-list">
                    
                    
                </ul>
            </div>
        </div>
        
        <div class="panel-body">
            
            <div class="search-input form-group " >
                <input id="search_field" type="search" class="form-control" v-model="searchString" @keyup="search" placeholder="Search">
            </div>
            <div id="hot-preview"  >
                <HotTable   ref="hot"
                            :root="root" 
                            :settings="hotSettings"
                            :data="leaves"
                            
                            >
                </HotTable>
            </div>
          
            <!--<modal v-if="showModal" 
                    :id="quantityId" 
                    :fileType="fileType"
                    :fileFormat="fileFormat"
                    @close="showModal = false"
                    :uploadUrl="uploadUrl">        
            
            </modal>-->

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



function strip_tags(input, allowed) {
    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
        commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;

    // making sure the allowed arg is a string containing only tags in lowercase (<a><b><c>)
    allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');

    return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
        return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
    });
}


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
        data() {              
            return {
                searchString: '',
                quantityId: '',
                fileType: '',
                fileFormat: '',
                uploadUrl: null, 
             
                showModal: false,
                leaves:  null,
                root: 'root',
                hotSettings: {
                  startCols: 10,           
                  rowHeaders: true,           
                  className: "htLeft",
                  rowHeaders: true,
                  autoColumnSize: true,
                  preventOverflow: 'horizontal',
                  search: true,
                  search: true,            
                  columns: [
                         
                          {data: 'code', readOnly: true, colWidths: '100px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                               return document.getElementById('hot-preview').offsetWidth - 705;
                          }},
                          {data: 'unit', readOnly: true, colWidths: '45px'},                          
                          {data: 'quantity', readOnly: true, colWidths: '85px'},
                          {data: 'a_quantity', readOnly: true, colWidths: '85px'},
                          {data: 'defer' , readOnly: true, type: 'numeric', format: '00.00 %', colWidths: '80px'},
                          {data: {}, readOnly: true, renderer: QLink, colWidths: '45px'},
                          {data: {}, readOnly: true, renderer: ALink, colWidths: '45px'},
                          {data: 'commit', readOnly: true, type: 'checkbox', colWidths: '40px'},
                          {data: {}, readOnly: true, renderer: Mrkd, colWidths: '45px'},
                          {data: {}, readOnly: true, renderer: Amrkd, colWidths: '45px'},
                          {data: 'a_commit', readOnly: true, type: 'checkbox', colWidths: '40px'},
                          
                          
                     
                  ],
                  colHeaders: ['Code', 'Name', 'Unit', 'Quantity', 'CQuantity',   'Defer', 'File', 'CFile', 'Cmt', 'Mrk','CMrk', 'CCmt'],
                 
             
                }
            }        
        },
        props: {
            info: null
        },  
        mounted() {
            let _this = this;
            this.getData();
            this.uploadUrl='/api/jobs/'+this.info.id+'/quantity/files';
            window.jid = this.info.id;
            bus.$on('showUploadModal', function(payload) {                
                 _this.quantityId = payload.quantityId;
                _this.fileType = payload.type;
                _this.fileFormat = payload.format;
                _this.showModal = true;

            });
            bus.$on('refreshtable', function() {
                _this.getData();
                _this.showModal = false;
            })

        },     
        watch: {
            'info.id': function() {
                this.getData();
                this.uploadUrl='/api/jobs/'+this.info.id+'/quantity/files';
                window.jid = this.info.id;
            }
        },  
            
        computed: {
            notifications() {
                return this.$store.state.notifications
            }, 
                    
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
                        e.a_commit = e.a_commit == 1? true: false;
                        e.p_commit = e.p_commit == 1? true: false;

                       return e;
                   });})
                 .catch((error)=>{
                   console.log(error)});               
            },
            search() {    
                var queryResult = this.$refs.hot.table.search.query(this.searchString);                
                this.$refs.hot.table.render();              
  
            }

        }
      
    }
</script>




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
           <div  id="hot-preview">            
                <HotTable   ref="hot"
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

// import moment from 'moment';
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





function ALink(instance, td, row, col, prop, value, cellProperties) {

    var rowData = instance.getSourceDataAtRow(row);

    var escaped = Handsontable.helper.stringify(value);

    if(rowData.combined_a_file)
    {
        escaped = '<a href="/api/downloads/jobs/afiles/'+rowData.job_id+'/'+rowData.code+'" targer="_blank" download><i class="icon-download10" ></i></a>';
        escaped = strip_tags(escaped, '<em><b><strong><a><i><big>'); 
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
        props: ['job'],
              
        components: {         
            HotTable,               
                      
        },
        data() {              
            return {
                loading: true,
                searchString: '',
                searchInput: {},
                quantityId: '',
                fileType: '',
                fileFormat: '',        
                leaves:  null,
                root: 'quantity',
                hotSettings: {
                  startCols: 10,           
                  rowHeaders: true,            
                  className: "htLeft",
                  rowHeaders: true,
                  preventOverflow: 'horizontal',
                  search: true,
                  columns: [
                         
                          {data: 'code', readOnly: true, colWidths: '100px'},
                          {data: 'name', readOnly: true, colWidths: function(){
                               return document.getElementById('hot-preview').offsetWidth - 410;
                          }},
                          {data: 'unit', readOnly: true, colWidths: '45px'},                         
                          {data: 'a_quantity', readOnly:true, colWidths: '80px'},                       
                          {data: '', renderer: ALink, readOnly: true, colWidths: '45px'},
                          {data: '', renderer: Amrkd, readOnly: true, colWidths: '45px'},
                          {data: 'p_commit', type: 'checkbox', readOnly: true, colWidths: '45px'}
                  ],
                  colHeaders: ['Code', 'Name', 'Unit', 'Quantity', 'AFile', 'AMrk', 'Cmt'],
       
                }
            }        
        },
       
        mounted() {
            let _this = this;
            this.getData();
            this.searchInput = document.getElementById('search_field');       

        },     
      

        methods: {
            getData() {
                if(this.job.id)
                axios.get('/api/jobs/'+this.job.id+'/quantity')
                 .then(({data})=>{
                     data = data.sort(function(a, b){
                         return a.code - b.code > 0? 1: a.code - b.code < 0? -1: 0;
                     });      
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
  
            }

            

        }
      
    }
</script>

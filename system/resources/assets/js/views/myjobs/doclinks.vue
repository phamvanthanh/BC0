<template  >
 <div class="panel panel-flat">
    <div :class="{loader:loading}"></div>
    <div :class="{hidden:loading}" class="panel-heading">             
        <div class="heading-elements">
            <div class="heading-btn">
                
            </div>                   
        </div>
    </div>           
    <div :class="{hidden:loading}" class="panel-body">
            <div v-if="links.length > 0">
                <v-client-table
                    :data="links"
                    :columns="columns"
                    :options="options">
                    <template slot="url" scope="props">
                            <a :href="props.row.url" target="_blank" >{{props.row.url}}</a> 
                    </template>
                </v-client-table>
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


import ClientTable from 'vue-tables-2';
Vue.use(ClientTable, {
    compileTemplates: true,

});

export default {
  
    data() {
        return {
            loading: true,          
             links: [],
              columns: [
                'id',  
                'link',    
                'name',
                'created_at',                
            ],
            
         
             columns: ['id', 'caption', 'url',  'created_at'],
             options: {
                headings: {
                    id: 'Id',
                    caption: 'Caption',
                    url: 'Link',        
                    created_at: 'Created',
                    actions: 'Actions'         
                  
                },
                columnsClasses: {
                    id: 'w-70',
                    caption: 'w-150',
                    url: 'column-expanded',                   
                    created_at: 'w-150',
                },
                sortIcon: { 
                    base: '',  up:'icon-arrow-up5', down:'icon-arrow-down5'
                },
                skin: 'table-hover',
                texts: {
                    filter: ''
                }
            },        
        }
    },
    props: {
        info: {}
    },
   
    created() {        
        this.getLinks();      
    },
    watch: {
        'info.project.id': function() {
             this.getLinks();
        }
        
    },

    methods: {
   

        getLinks() {
           
            if(this.info.project)
                axios.get('/api/projects/'+this.info.project.id+'/links')
                    .then(({data})=>{
                        
                        this.links = data.map(function(e) {
                            return {
                                id: e.id,
                                caption: e.caption,
                                url: e.url,
                                created_at: moment(e.created_at).format('YY/MM/DD')
                            };
                        });
                        this.loading = false;
                    })
                    .catch((error)=>console.log(error));
        }, 
 
        

    }


}
</script>
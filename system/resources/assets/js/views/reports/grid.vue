<template>   
   <grid       
        :data="gridData"
        :labels="localLabels" >
   </grid>
</template>
<script>
import grid from './grid/grid';
export default {
    props: ['job', 'data', 'labels'],
    data(){
        return {
            gridData: null,
            localLabels: []
        }
    },
    created() {
        if(this.job )
            this.getData(this.job.id);
            
        if(this.data) {
          
            this.localLabels = this.labels;
            this.gridData = this.data;
        }            
    },
    watch: {
        'job.id': function(val) {
            this.getData(val);
        }
    },

    components: {
        grid,
    },

    methods: {

        getData(id) {            
            axios.get('/api/jobs/'+id+'/quantity')
                 .then(({data})=>{
                     if(data){
                          data = data.sort(function(a, b){
                            return a.code - b.code > 0? 1 : a.code - b.code < 0? -1: 0;
                        });
                        this.localLabels = data.map(function(e) {
                            return (e.name +' - '+ e.code).toString();
                        }); 
                        this.gridData = data.map(function(e) {
                            return e.commit_array.map(function(u){
                                return {
                                    
                                    job_id: u.job_id,
                                    code: e.code,
                                    name: e.name,
                                    package: u.name,
                                    quantum: u.quantum,
                                    totalQuantum: e.quantum,
                                    quantified: u.commit == 1? 'Yes': 'No',
                                    audited: u.a_commit == 1? 'Yes': 'No',
                                    color: u.a_commit == 1? 'rgba(76,175,80,0.7)': u.commit == 1? 'rgba(255,0,0,0.4)': 'rgba(204, 204, 204, 0.3)',
                                    
                                }
                            })                           
                        });         
                     }                              

                 })           
             
        }
    }
}

</script>
<style >
.grid-line {
    font-size: 0;
    margin: 0px;
    padding:  0px;
    border: none;
    display: block;
    box-sizing: border-box;
}
.chart-item-container,
.chart-container {
    display: inline-block;
    margin: 0;
    padding: 0;
    
}
.chat-item-container .chart-item {
    display: block;
   
}
#grid-chart {
    width: calc(100% - 20px);
   
}

</style>
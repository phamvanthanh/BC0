<template>
<div class="panel panel-flat" id="stackedbar_chart" >
    <stacked-Bars
        v-if="localdata"
        :data ="localdata"
        barHeight="20"
        :width="width"
        :options = "options"
        title="Stacked Packages"
        
    >
    </stacked-bars>
</div>

</template>
<script>
import stackedBars from '../charts/stackedBars';
export default {
    props: ['job', 'data', 'labels'],
    data(){
        return {
            localdata: null, 
            options: {
                notations: [
                    {name: 'Not Quantified', color: '#E8E8E8'},
                    {name: 'Quantified', color: 'orange'},
                    {name: 'Audited', color: 'steelblue' }],
            },
            width: 0
            

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
    mounted() {
        this.width = document.getElementById('stackedbar_chart').offsetWidth - 100;
    },
    watch: {
        'job.id': function(val) {
            this.getData(val);
        }
    },
    components: {
        stackedBars
    },
 
    methods: {
        getData(id) {            
            axios.get('/api/jobs/'+id+'/quantity')
                 .then(({data})=>{
                     if(data){
                        data = data.sort(function(a, b){
                            return parseInt(b.code) - parseInt(a.code);
                        });
                     
                        var localdata = data.map(function(e) {
                            return {
                                label: e.name + ' - ' + e.code,
                                code: e.code,
                                quantum: e.quantum,
                                packages: e.commit_array
                                
                            }
                        }); 

                         this.localdata = localdata.map(function(e){
                                var packages = e.packages
                                for( var i = 0; i < packages.length; i++) {
                                
                                    if(i > 0)
                                        packages[i].x = packages[i-1].x + packages[i].quantum;
                                    else
                                        packages[i].x = 0;
                                }
                                return e;
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

<template>
    <div class="panel panel-flat" style="min-height: 100px" >
        <div :class="{loader:loading}"></div>  
        <div :class="{hidden:loading}" class="panel-heading">
            <h6 class="panel-title">Items Progess</h6>
            <div class="heading-elements">
                <ul class="icons-list">
                    
                    
                </ul>
            </div>
        </div>
        
        <div v-if="showChart" :class="{hidden:loading}" class="panel-body">
            <div  class="wrapper">
                <chartjs-horizontal-bar         
                    :height="chartHeight"
                    :labels = "labels" 
                    :datasets="datasets"
                    :bind="true"
                    :beginzero="true"         
                    :option="options"
                    >
                </chartjs-horizontal-bar>
            </div>
        </div>    
    </div>
</template>

<script>

import 'chart.js';
import 'hchs-vue-charts';

export default {
    props: ['job', 'data'],

    data() {
        return {
            loading: true,
            labels: [],
            chartHeight: 50,
            datasets: [
                {
                    label: "Audit %",
                    data: [],
                    backgroundColor: 'rgba(76,175,80,0.8)',
                    borderSkipped: 'right'
                },  {
                    label: "Quantify %",
                    data: [],
                    backgroundColor: 'rgba(255,0,0,0.4)',                   
            }], 

            options:{
                responsive:true,
                maintainAspectRatio:true,
         
                scales: {
                    xAxes: [{
                        stacked: false,
                        ticks: {
                            min: 0,
                            max: 100,   
                            beginAtZero: true,                    
                        }
                    }],
                    yAxes: [{
                        stacked: true
                    }],
                   
                }, 
                tooltips: {
                    callbacks: {
                        label: function(tooltipItem, data) {
                          
                             if(tooltipItem.datasetIndex == 0)
                                return 'Audit: '+ tooltipItem.xLabel.toPrecision(4)+ ' %'; 
                             if(tooltipItem.datasetIndex == 1)
                                return 'Quantity: '+ tooltipItem.xLabel.toPrecision(4)+ ' %'; 
                       
                        }
                    }
                }
            } 
        }
    },

    created() {
         if(this.job)
            this.getData(this.job.id);
    },
    watch: {
        'job.id': function(val) {
            if(val)
                this.getData(val);
        }
    },
    computed: {
        showChart: {
            get(){
                return (this.datasets[0].data.length > 0 || this.datasets[1].data.length > 0)
            },
            set(newVal) {
            }
        }
    },
    methods: {
        getData(jid) {
            if(jid)
                axios.get('/api/jobs/'+jid+'/quantity')
                    .then(({data})=>{ 
                        data = data.sort(function(a, b){
                            return a.code - b.code > 0? 1 : a.code - b.code < 0? -1: 0;
                        });
                       
                        this.chartHeight = 6*data.length +16;       
                        this.updateData(data);
                        this.loading = false;
                    });
        },
        updateData(data) {             
            
            this.labels = data.map(function(e) {
                return (e.name + ' - ' + e.code);
            }); 

            this.datasets[1].data =  data.map(function(e) {
                if(e.quantum)
                    return 100*((e.cmtd_quantum)/e.quantum); 
                return 0;
            });

            this.datasets[0].data =  data.map(function(e) {
                if(e.quantum)
                    return 100*((e.cmtd_a_quantum)/e.quantum); 
                return 0;
            });
            
        }, 
    }
}

</script>

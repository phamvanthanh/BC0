<template>
<div>
    <div :class="{loader:loading}"></div>
    <div :class="{hidden:loading}">
        <div  class="panel panel-flat">
            
            <div   class="panel-heading">
                <h6 class="panel-title">Items Progess</h6>
                <div class="heading-elements">
                    <ul class="icons-list">
                        
                        
                    </ul>
                </div>
            </div>
            
            <div   class="panel-body">
                <div  class="wrapper">

                    <chartjs-horizontal-bar         
                        :height="chartHeight"
                        :labels = "labels" 
                        :datasets="data"
                        :bind="true"
                        :beginzero="true"         
                        :option="options"
                        >
                    </chartjs-horizontal-bar>
                </div>
            </div>    
        </div>
        <div class="horizontal-divider"></div>
        <div class="panel panel-flat">
    
            <div class="panel-heading">
                <h6 class="panel-title">Overall progress</h6>
                <div class="heading-elements">
                    <ul class="icons-list">
                        
                        
                    </ul>
                </div>
            </div>
            
            <div  class="panel-body">
                <div  class="chart-wrapper"  >
                    <!--<canvas id="lineCanvas" count="1"></canvas>   v-if="cmtLineLabels.length > 0 && totalQuantum > 0"-->
                    <scatter
                        :datasets="scatterDataSets"
                        :options="scatterOptions"
                        :height="120"                    
                    ></scatter>
                    
                </div>
            </div>    
        </div>
    
        <div class="horizontal-divider"></div>
        <grid 
        
            v-if="gridData"
            :data="gridData"             
            :labels="labels"                        
            >
        </grid>
    </div>


</div>
</template>
<script>

import 'chart.js';
import 'hchs-vue-charts';
import grid  from './../../reports/grid';
import scatter from './reports/scatter';

 Vue.use(window.VueCharts);



export default {
    props: ['info'],

    data() {
        return {
            loading: true,
           
            rawData: [],
            totalQuantum: 0,             
            // cmtLineLabels: [],
            // auditCmtLineLabels: [],
            cmtdLineData: [],
            auditCmtdLineData: [],
            test: [{data:[{x:5, y: 7}, {x: 7, y: 9}]}],
            test1: [1, 4, 5, 6, 7],
            scatterDataSets: [{ 
                label: 'Quantify %',             
                data:[],
                lineTension: 0,
                borderColor: 'rgba(255,0,0,0.7)',
                backgroundColor: 'transparent',
                radius: 0,
                borderWidth: 2
            }, {
                label: 'Audit %',
                data: [],
                lineTension: 0,
                borderColor: 'rgba(76,175,80,0.7)',
                backgroundColor: 'transparent',
                radius: 0,
                borderWidth: 2
                
            }],
            dates: [],
          
            chartHeight: 100,
            labels: [],
        
            data: [ {
                    label: "Audit %",
                    data: [],
                    backgroundColor: 'rgba(76,175,80,8)',
                    borderSkipped: 'right'
                },{
                    label: "Quantify %",
                    data: [],
                    backgroundColor: 'rgba(255,0,0,0.4)', 
                                    
                } ],      

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
            },

            gridData: null,
            gridWidth: 600,
            scatterOptions: {
                scales: {
                    xAxes: [{
                        type: 'time',
                        time: {
                            displayFormats: {
                            
                                'day': 'll',
                        
                            }
                    }
                    }],
                    yAxes: [{
                            stacked: false,
                            ticks: {
                                beginAtZero: true,
                                min: 0,
                                max: 100,
                            
                            }
                        }],
                }
            }          
  
        }
    },

    computed: {
        lineLabels: function() {
            var dates = [];
            for(var i = 0; i < this.rawData.length; i++){
            
                for(var j = 0; j < this.rawData[i].commit_array.length; j++){
                    var cmt =  this.rawData[i].commit_array[j]
                    if(cmt.commit == 1){
                        if(moment(cmt.committed_at).format('L') != dates[dates.length-1] )
                            dates.push(moment(cmt.committed_at).format('L'));
                    }
                        
                }
            }
            return dates;

        },
        lineOptions: function () {
            return  {
                    responsive:true,
                    scales: {
                        yAxes: [{
                            stacked: false,
                            ticks: {
                                beginAtZero: true,
                                min: 0,
                                max: 100,
                            // stepSize: 1300
                            }
                        }],
                    xAxes: [{
                        stacked: false,
                        ticks: {
                            min: moment(this.info.from_date).format('L'),
                            max: moment(this.info.to_date).format('L')
                        }
                    }]
                   
                   
                }

            }
        }

    },    

    components: {
        grid,
        scatter
    },
    created() {
       
    },
    mounted() {
        this.getData();
      
    }, 
  
    watch: {
        'info.id': function() {
            this.getData(); 
        },
       
    }, 

    methods: {

            getData() {
                if(this.info.id)
                axios.get('/api/jobs/'+this.info.id+'/quantity')
                     .then(({data})=>{ 
                         data = data.sort(function(a, b){
                             return a.code - b.code > 0? 1 : a.code - b.code < 0? -1: 0;
                         });
                         
                         this.rawData = data;
                         this.chartHeight = 6*data.length+16;        
                         this.updateData(data);
                         // BEGIN OF GRID DATA
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
                        
                        // END OF GRID DATA
                        // BEGIN OF LINES DATA
                        var  cmtdLineData = [], totalQuantum = 0, auditCmtdLineData = [];
                        //Commit line data
                        // cmtdLineData.push({date:this.info.from_date, a_date: this.info.from_date, quantum: 0, commit: 0, a_commit: 0});
                        for(var i = 0; i < data.length; i++){ // Loop for items
                       
                            for(var j = 0; j < data[i].commit_array.length; j++){ // loop for commit package of each item
                                
                                var cmt =  data[i].commit_array[j]; // commit of item in each package
                                totalQuantum += cmt.quantum; // Total quantum of item
                                if(cmt.commit == 1){ 
                                       // if a package item is commited, push to cmtdLineData
                                        cmtdLineData.push({date:cmt.committed_at,  quantum: cmt.quantum, commit: cmt.commit, a_commit: cmt.a_commit});
                                  
                                }
                                if(cmt.a_commit == 1) {
                                    auditCmtdLineData.push({a_date:cmt.a_commited_at, quantum: cmt.quantum, a_commit: cmt.a_commit});
                                }
                                    
                            }
                        }
                        // console.log(cmtdLineData);
                        this.totalQuantum = totalQuantum; //Get the  total quantum

                        // Re-arrange cmtdLineData by date
                        cmtdLineData = cmtdLineData.sort(function(a, b){
                            return a.date > b.date ? 1: (b.date > a.date ? -1 : 0);
                        });

                        auditCmtdLineData = auditCmtdLineData.sort(function(a, b){
                            return a.a_date > b.a_date ? 1: (b.a_date > a.a_date ? -1 : 0);
                        })

                        //cmtdLineData labels are commit dates
                        // this.cmtLineLabels = cmtdLineData.map(function(e){
                        //     return e.date;
                        // });
                        // this.auditCmtLineLabels = cmtdLineData.map(function(e){
                        //     return e.a_date;
                        // });
                 

                        for(var i = 0; i < cmtdLineData.length; i++){ // Loop cmtdLineData to convert quantum to %
                            var x = this.cmtdLineData, y = this.auditCmtdLineData, el, el1;
                            if(i > 0) {
                               
                                 el = 100*(cmtdLineData[i].commit*cmtdLineData[i].quantum/totalQuantum) + x[x.length-1];
                                 
                                //  el1 = 100*(cmtdLineData[i].a_commit*cmtdLineData[i].quantum/totalQuantum) + y[y.length-1];
                                 
                                // if(cmtdLineData[i].a_commit > 0){

                                //     this.scatterDataSets[1].data.push({x: moment(cmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                                // }
                                    
                                    
                            }
                            else { // With i = 0 
                                 el = 100*(cmtdLineData[i].commit*cmtdLineData[i].quantum/totalQuantum);
                                //  el1 = 100*(cmtdLineData[i].a_commit*cmtdLineData[i].quantum/totalQuantum);
                                //  this.scatterDataSets[1].data.push({x: moment(cmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                                 
                          
                            }
                            this.cmtdLineData.push(el);
                            // this.auditCmtdLineData.push(el1); 
                            this.scatterDataSets[0].data.push({x: moment(cmtdLineData[i].date).add(0, 'days').valueOf(), y: el });
                               
                        }

                        for(var i = 0; i < auditCmtdLineData.length; i++){ // Loop cmtdLineData to convert quantum to %
                            var  y = this.auditCmtdLineData, el1;
                            if(i > 0) {
                               
                                //  el = 100*(cmtdLineData[i].commit*cmtdLineData[i].quantum/totalQuantum) + x[x.length-1];
                                 
                                 el1 = 100*(auditCmtdLineData[i].a_commit*auditCmtdLineData[i].quantum/totalQuantum) + y[y.length-1];
                                 
                                // if(cmtdLineData[i].a_commit > 0){

                                //     this.scatterDataSets[1].data.push({x: moment(cmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                                // }
                                    
                                    
                            }
                            else { // With i = 0 
                                //  el = 100*(cmtdLineData[i].commit*cmtdLineData[i].quantum/totalQuantum);
                                 el1 = 100*(auditCmtdLineData[i].a_commit*auditCmtdLineData[i].quantum/totalQuantum);
                                //  this.scatterDataSets[1].data.push({x: moment(cmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                                 
                          
                            }
                            // this.auditCmtdLineData.push(el);
                            this.auditCmtdLineData.push(el1); 
                            this.scatterDataSets[1].data.push({x: moment(auditCmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                               
                        }


                         this.loading = false;
                         
                     })
                     .catch((error)=>{
                         console.log(error)});               
            },

            updateData(data) {             
          
                this.labels = data.map(function(e) {
                    return (e.name +' - '+ e.code).toString();
                }); 
        
                this.data[1].data =  data.map(function(e) {
                    if(e.quantum)
                        return 100*((e.cmtd_quantum)/e.quantum); 
                    return 0;
                });

                this.data[0].data =  data.map(function(e) {
                    if(e.quantum)
                        return 100*((e.cmtd_a_quantum)/e.quantum); 
                    return 0;
                });
                
            }, 

            // getStacks() {

            //     if(this.info.id)
            //         axios.get('/api/jobs/'+this.info.id+'/stacks')
            //              .then(({data})=>{console.log(data)})
            //              .catch(({error})=>{console.log(error)})

            // }        

        }

}

</script>

<style>
div#chart-indicator ul li {
    display: inline;
}
#audit-indicator, #quantity-indicator {

    height: 12px;
    padding-left: 20px;
    padding-right: 20px;

}

#audit-indicator {
    background-color: rgba(76,175,80,0.7);
}
#quantity-indicator {
    background-color: rgba(255,0,0,0.4);
}

</style>
    <template>
    <div class="panel panel-flat" style="min-height: 100px" >
        <div :class="{loader:loading}"></div>  
        <div :class="{hidden:loading}" class="panel-heading">
            <h6 class="panel-title">Overall Lines</h6>
            <div class="heading-elements">
                <ul class="icons-list">
                    
                    
                </ul>
            </div>
        </div>
        
        <div :class="{hidden:loading}" class="panel-body">
            <div  class="chart-wrapper"  >
                    <!--v-if="cmtLineLabels.length > 0 && totalQuantum > 0"-->
                <scatter
                    :datasets="datasets"
                    :options="options"
                    :height="120"                    
                ></scatter>
                
            </div>
        </div>    
    </div>
    </template>
<script>

import scatter from './scatter';

export default {

    props: ['job', 'data'],

    data() {
        return {
            loading: true,
            totalQuantum: 0,             
            cmtLineLabels: [],
            // auditCmtLineLabels: [],
            cmtdLineData: [],
            auditCmtdLineData: [],
 

            datasets: [{
                label: 'Quantify Progress %',
                data:[],
                lineTension: 0,
                borderColor: 'rgba(255,0,0,0.6)',
                backgroundColor: 'transparent',
                radius: 0,
                borderWidth: 2
            }, {
                label: 'Audit Progress %',
                data: [],
                lineTension: 0,
                borderColor: 'rgba(76,175,80,0.8)',
                backgroundColor: 'transparent',
                radius: 0,
                borderWidth: 2
                
            }],

            options: {
            
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
                },
                
            } 
            
        }
    },
    components: {
       scatter
    },
    mounted() {
        if(this.job)
            this.getData(this.job.id);
    },

    watch: {
        'job.id': function(val) {
            if(val)
                this.getData(val);
        }
    },

    methods: {
      getData(jid) {
                axios.get('/api/jobs/'+jid+'/quantity')
                     .then(({data})=>{ 
                   
                         data = data.sort(function(a, b){
                             return a.code - b.code > 0? 1 : a.code - b.code < 0? -1: 0;
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
                           
                                    
                            }
                            else { // With i = 0 
                                 el = 100*(cmtdLineData[i].commit*cmtdLineData[i].quantum/totalQuantum);
                                //  el1 = 100*(cmtdLineData[i].a_commit*cmtdLineData[i].quantum/totalQuantum);
                                //  this.scatterDataSets[1].data.push({x: moment(cmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                                 
                          
                            }
                            this.cmtdLineData.push(el);
                            // this.auditCmtdLineData.push(el1); 
                            this.datasets[0].data.push({x: moment(cmtdLineData[i].date).add(0, 'days').valueOf(), y: el });
                               
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
                            this.datasets[1].data.push({x: moment(auditCmtdLineData[i].a_date).add(0, 'days').valueOf(), y: el1 });
                               
                        }


                         this.loading = false;              
                    
    
                 
                         
                     })
                     .catch((error)=>{
                         console.log(error)});               
            },


    }
}

</script>
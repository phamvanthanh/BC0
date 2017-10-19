<template>
    <div class="panel panel-flat" id="timelines_chart" >
        <timelines
            v-if="datasets[0].data.length >0"
            :datasets="datasets"
            yText="Complete (%)"
            :height="300"
            :width="width"
        >
        </timelines>
    </div>
</template>
<script>

import timelines from './D3/timelines';

export default {

    props: ['job', 'data'],

    data() {
        return {     
            width: 0,
            datasets: [{
                label: 'Quantified (%)',
                data:[],             
                color: 'orange'
              
            }, {
                label: 'Audited (%)',
                data: [],               
                color: 'steelblue'               
            }],       
            
        }
    },
    components: {
       timelines
    },
    mounted() {
        if(this.job)
            this.getData(this.job.id);
        this.width = document.getElementById('timelines_chart').offsetWidth - 100;
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

                    // BEGIN OF LINES DATA
                    var  cmtdLineData = [], totalQuantum = 0, auditCmtdLineData = [];
                    //Commit line data
                    for(var i = 0; i < data.length; i++){ // Loop for items
                    
                        for(var j = 0; j < data[i].commit_array.length; j++){ // loop for commit package of each item
                            
                            var cmt =  data[i].commit_array[j]; // commit of item in each package
                            totalQuantum += cmt.quantum; // Total quantum of item
                            if(cmt.commit == 1){ 
                                    // if a package item is commited, push to cmtdLineData
                                    cmtdLineData.push({date:cmt.committed_at,  quantum: cmt.quantum, commit: cmt.commit, a_commit: cmt.a_commit});
                            }
                            if(cmt.a_commit == 1) {
                                // if a package item is audited, push data to auditCmtdLineData
                                auditCmtdLineData.push({a_date:cmt.a_committed_at, quantum: cmt.quantum, a_commit: cmt.a_commit});
                            }
                                
                        }
                    }
                    // console.log(cmtdLineData);
                    this.totalQuantum = totalQuantum; //Get the  total quantum
                    cmtdLineData.unshift({
                        date: this.job.from_date+' 00:00:00',
                        quantum: 0,
                        commit: 0,
                        a_commit: 0
                    });

                    auditCmtdLineData.unshift({
                        a_date: this.job.from_date+' 00:00:00',
                        quantum: 0,
                        a_commit: 0                        
                    });
                    
                    // Re-arrange cmtdLineData by date
                    cmtdLineData = cmtdLineData.sort(function(a, b){
                        return a.date > b.date ? 1: (b.date > a.date ? -1 : 0);
                    });

                    auditCmtdLineData = auditCmtdLineData.sort(function(a, b){
                        return a.a_date > b.a_date ? 1: (b.a_date > a.a_date ? -1 : 0);
                    })
                    
                    var commQ = 0; //Commulated Committed Quantum
                    for(var i = 0; i < cmtdLineData.length; i++){ // Loop cmtdLineData to convert committed quantum to %
                        var x = this.cmtdLineData, y = this.auditCmtdLineData, el, el1;                                                     
                        
                        commQ = 100*(cmtdLineData[i].commit*cmtdLineData[i].quantum/totalQuantum) + commQ;                           
                        //Push to datasets commited data            
                        this.datasets[0].data.push({x: cmtdLineData[i].date, y: commQ });
                            
                    }
                    
                    commQ = 0; //Commulated Committed Audit Quantum
                    for(var i = 0; i < auditCmtdLineData.length; i++){ // Loop cmtdLineData to convert quantum to %
                                                
                        commQ = 100*(auditCmtdLineData[i].a_commit*auditCmtdLineData[i].quantum/totalQuantum) + commQ;
                        //Push to datasets auditted data
                        this.datasets[1].data.push({x: auditCmtdLineData[i].a_date, y: commQ });
                            
                    }


                    })
                    .catch((error)=>{
                        console.log(error)});               
        }
    }
}

</script>
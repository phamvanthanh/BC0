<template>
    <div class="panel panel-flat" id="itemprogress_chart"  >
        <horizontal-bars
            v-if="localdata"
            :data = "localdata"
            barHeight="18"
            :width="width"
            :keys="keys"
            :options="options"
            title="Work Item Progresses"
            >
        </horizontal-bars>
    </div>
</template>

<script>

import horizontalBars from '../charts/horizontalBars';

export default {
    props: ['job', 'data'],

    data() {
        return {
            width: 0,
            labels: [],
            keys: ['quantify', 'audit'],
            colors: ["rgb(255, 165, 0)", "rgb(70, 130, 180)" ],
            localdata: null,
            options: {
                notations: [
                    {name: 'Quantified (%)', color: "rgb(255, 165, 0)"},
                    {name: 'Audited (%)', color: "rgb(70, 130, 180)"}
                ]
            }
          
        }
    },

    components: {
        horizontalBars
    },

    created() {
         if(this.job)
            this.getData(this.job.id);
    },
    mounted() {
         this.width = document.getElementById('itemprogress_chart').offsetWidth - 100;
    },
    watch: {
        'job.id': function(val) {
            if(val)
                this.getData(val);
        }
    },
    computed: {

    },
    methods: {
        getData(jid) {
            if(jid)
                axios.get('/api/jobs/'+jid+'/quantity')
                    .then(({data})=>{ 
                        data = data.sort(function(a, b){
                            return (parseInt(b.code) - parseInt(a.code));
                        });
                        this.updateData(data);             
                    });
        },
        updateData(data) {             
     
            this.localdata =  data.map(function(e) {
                if(e.quantum)
                    return {
                        label: (e.name + ' - ' + e.code),
                        quantify: 100*((e.cmtd_quantum)/e.quantum),
                        audit: 100*((e.cmtd_a_quantum)/e.quantum)
                    }  
               
            });

        }, 
    }
}

</script>

<style>

g.stick text{
  fill: rbga(0, 0, 0, 0.7);
}
</style>

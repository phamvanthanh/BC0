

<script>
 


Vue.component('square', {
  props: ['linewidth', 'height', 'color', 'border', 'display', 'text', 'data', 'tooltiptext'],
  template: `<div class="grid-el tt" :style="style" > <span class="tooltiptext" v-if="data">
                    Job Id: {{data.job_id}}<br>
                    Package: {{data.package}}<br>
                    Code: {{data.code}}<br>
                    Quantified: {{data.quantified}}<br>
                    Audited: {{data.audited}}<br>
             </span><span class="chart-text">{{text}}</span></div>`,
  data() {
      return {
          defaultWidth: '20px',
          defaultHeight: '18px', 
          defaultBorder: '1px',
          defaultColor: '#ccc',
      }
  },
  computed: {
  
      style: function()  { 
          return {
           
            //  'min-width':  this.defaultWidth,
             width: this.linewidth? this.linewidth*(this.data.quantum / this.data.totalQuantum)+'px': 'auto', 
             height: this.height? this.height+'px': this.defaultHeight, 
             border:  this.border? this.border+'px': this.defaultBorder,
             'background-color': this.color? this.color: this.defaultColor,
             display: this.display? this.display : 'block',          
             'border-style': 'solid',
             'border-color': '#fff',
            //  'box-sizing': 'border-box',
             'font-family': 'inherit',
             'font-size' : '12px',
             'line-height': this.height? this.height+'px': this.defaultHeight,
           
             
          }
        
      },

     
  },
  mounted() {

  },

  methods: {
      openJob() {
          router.push({name: 'quantity', params: {id: this.data.job_id}});
      }
  }
});

</script>
<style>
.chart-text {
    /*font-size: 18px;*/
    float: right;
    clear: both;
    z-index: 99;
   
}
.grid-el:hover {
    cursor: pointer;
    overflow: visible;
     /*border-style: solid;
     border-color: #fff;*/
}

.tt {
    position: relative;
    display: inline-block;
    border-bottom: 1px dotted black;
}

.tt .tooltiptext {
    visibility: hidden;
    width: 180px;
    background-color: #555;
    color: #fff;
    text-align: left;
    border-radius: 6px;
    padding: 5px 5px;
    position: absolute;
    z-index: 1;
    top: 125%;
    left: 50%;
    margin-left: -60px;
    opacity: 0;
    transition: opacity 1s;
}

.tt .tooltiptext::after {

    width: 0; 
    height: 0; 
    border-left: 5px solid transparent;
    border-right: 5px solid transparent;
  
    border-bottom: 5px solid #555;

    content: "";
    position: absolute;
    top: -5%;
    left: 50%;

}

.tt:hover .tooltiptext {
    visibility: visible;
    opacity: 1;
}

</style>
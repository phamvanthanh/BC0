<script>
import { Scatter } from 'vue-chartjs';

export default Scatter.extend({
  props: ['datasets'],
  mounted () {
    // Overwriting base render method with actual data.
    this.renderChart(
    //   labels: ['January', 'February', 'March', 'April', 'May', 'June'],
      {datasets: this.datasets}, 
      // Options
       {
           scales: {
                xAxes: [
                    {
                    
                    type: 'time',
                    time: {
                        unit: 'day',
                        displayFormats: {
                        
                            'day': 'DD/MM/YY',
                    
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
                }]
            },

            title: {
                text: 'Overall Progess'
            },
            
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return moment(tooltipItem.xLabel).format('MMMM, DD, YY')+ ': '+tooltipItem.yLabel.toPrecision(4)+ ' %';
                    }
                }
            }
        }
      
   
    )
  },

})
</script>
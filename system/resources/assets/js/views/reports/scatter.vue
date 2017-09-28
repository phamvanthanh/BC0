<script>
import { Scatter } from 'vue-chartjs';
export default Scatter.extend({
  props: ['datasets'],
  mounted () {
   
    this.renderChart(
  
      {datasets: this.datasets}, 
   
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
            pointBackgroundColor: '#fff',
            pointBorderColor: '#fff',
            tooltips: {
                callbacks: {
                    label: function(tooltipItem, data) {
                        return moment(tooltipItem.xLabel).format('LL')+ ' , '+tooltipItem.yLabel.toPrecision(4)+ ' %';
                    }
                }
            }
        }   
   
    )
  },

});
</script>

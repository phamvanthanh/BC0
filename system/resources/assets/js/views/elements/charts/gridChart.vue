<template>
   <div id="grid-chart" class="grid-chart">
       <div id="chart-item-container" class="chart-item-container" >
               <square v-for="el in labels"
                        :key="el" 
                        :height="elHeight"                                        
                        :display="'block'"
                        :text="el"
                        :color="'transparent'"                        
                > 
                    
                </square>
           

        </div>
        <div class="chart-container">
            <div class="grid-line" v-for="line in data" >
                <square v-for="el in line"
                        :key="el.id" 
                        :height="elHeight"
                        :linewidth="lineWidth"
                        :color="el.color"
                        :display="'inline-block'"  
                        :id = 'el.job_id'
                        :data = "el"                   
                        
                 > 
                 
                </square>
            </div>
        </div>
   </div>

</template>
<script>
import square from './square';
export default {
    props: ['data', 'labels', 'options', 'height', 'width'],
    data() {
        return { lineWidth: 0
        
        }
    },
    computed: {
        xEls: function () {
            if(this.data) {
                var i, xLength = 0;
                for( i = 0; i < this.data.length; i++) {
                    if(this.data[i].length > xLength)
                        xLength = this.data[i].length;
                }
                return xLength;
            }
            return 1;
        },

        yEls: function() {
            if(this.data)
                return this.data.length;
            return 0;            
        },

        
        elHeight: function() {
            if(this.height){
                  if(this.yEls > 0)
                    return this.height / this.yEls;
                  return null;
            }
              
            return null;
        }


    },
    updated() {
        
          if(this.width){
                if(this.xEls)
                    this.lineWidth = this.width;
                else
                    this.lineWidth = 0;
                    
          }
          else {
               let containerWidth = document.getElementById('grid-chart').offsetWidth;
               let labelWidth = document.getElementById('chart-item-container').offsetWidth;
        
               this.lineWidth = (containerWidth - labelWidth -20);    

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
    width: 100%;
    /*overflow-x: hidden;*/
}

</style>
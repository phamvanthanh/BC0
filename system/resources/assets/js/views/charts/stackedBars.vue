<template>
    <svg id='stacked-svg'>

    </svg>
</template>
<script>
export default {
    props: ['data', 'width', 'barHeight', 'options', 'title'],

    mounted() {
        this.initChart();
    },

    methods: {
        initChart() {
            var data = this.data,
            title = this.title,
            notes = this.options.notations,
            left = 100,
            margin = {top: 60, right: 20, bottom: 30, left: left},
            width = this.width - margin.left - margin.right,
            height = this.barHeight*this.data.length,
            color = d3.scaleOrdinal(d3.schemeCategory20),

            svg = d3.select("svg#stacked-svg"),
            
            title = svg.append('g')
                .attr('class', 'title_group')
                .attr("transform", "translate(" + left + "," + 36 + ")")
                .append('text')
                .text(title),            

            xScale = d3.scaleLinear()
                       .range([0, width])
                       .domain([0, d3.max(data, function(d){
                           return d.quantum
                       })]),
            
            xAxis = d3.axisBottom(xScale),

            yScale = d3.scaleBand()
                    .range([height, 0])
                    .padding(0.1)
                    .domain(data.map(function(d) {  return d.label; })),
            
            yContainer = svg.append("g")
                  .attr('class', 'item_label')              
                  .call(d3.axisLeft(yScale));

            var maxw = 0; //Find max label width
            yContainer.selectAll("text").each(function() {
                if(this.getBBox().width > maxw) maxw = this.getBBox().width;
            });

            // Set margin.left relative to max label width
            margin.left = Math.round(maxw + margin.left);

            //Define chart width
            var width = this.width - margin.left - margin.right;

            yContainer.attr("transform", "translate(" + margin.left + "," + margin.top + ")");
           
            var chart = svg.attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr('class', 'chart')
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
            
      
            
            for(var i = 0; i < data.length; i++) {
                
                var lane = chart.append('g')
                                .attr('class', 'stackedlane')
                                .attr('transform', 'translate(' + 0 + ',' + yScale(data[i].label) + ')');
                
                lane.selectAll("rect.stackedbar")
                .data(data[i].packages)
                .enter()
                .append("rect")
                .attr("class", "stackedbar")
                .attr("fill", function(d) {
                    return d.commit != 1? notes[0].color : d.a_commit != 1? notes[1].color : notes[2].color; 
                })
                .attr("width", function(d) {return xScale(d.quantum); } )                
                .attr("x",  function(d, j) {return xScale(d.x) + j*2})
                .attr("height", yScale.bandwidth())
                // .append("text")                
                // .attr('x', 6)
                // // .attr("dy", "0.71em")
                // .attr('fill', "#0000")
                // .text(function(d){return d.job_id;})
            }

            var legend = svg.append("g")
                .attr("class", "legend_container")
                .attr("transform", "translate(" + (width + margin.left + margin.right) + "," + 20 + ")" );

            var legend_items = legend.selectAll('g.legend')
                .data(notes)
                .enter()
                .append('g')
                .attr('class', 'legend')
                .attr('transform', function(d, i) { return  'translate(' + (150*i - 150*(notes.length)) + ',' + 0 + ')'; });

            legend_items.append('rect')
                .attr('width', 16)
                .attr('height', 16)
                .attr('x', 0)
                .attr('fill', function(d){
                    return d.color;
                });
            legend_items.append('text')
                .attr('x', 21)
                .attr("y", 9)
                .attr("dy", ".35em")                
                .text(function(d) { return d.name; });

        }
    }
    

}

</script>
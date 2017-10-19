<template>
    <svg id="horizontalbar_svg">

    </svg>
</template>
<script>
export default {
    props: ['data', 'barHeight', 'width', "keys", "options", 'title'],

    mounted() {
        this.initBarChart();
    },  
    methods: {
        initBarChart() {
            var data = this.data,
            keys = this.keys,
            title = this.title,
            notes = this.options.notations,
            left = 100,
            margin = {top: 60, right: 20, bottom: 30, left: left},                      
            height = this.barHeight*this.data.length,

            // select svg chart container
            svg = d3.select("svg#horizontalbar_svg"),            
            // set y axis
            y = d3.scaleBand()
                    .range([height, 0])
                    .padding(0.1)
                    .domain(data.map(function(d) {  return d.label; }));
            
            //Add left axis group and build
            var yAxisContainer = svg.append("g")
                  .attr('class', 'item_label')              
                  .call(d3.axisLeft(y));

            var maxw = 0; //Find max label width
            yAxisContainer.selectAll("text").each(function() {
                if(this.getBBox().width > maxw) maxw = this.getBBox().width;
            });

            // Set margin.left relative to max label width
            margin.left = Math.round(maxw+margin.left);

            //Define chart width
            var width = this.width - margin.left - margin.right;

            yAxisContainer.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            //Set x axis
            var x = d3.scaleLinear()
                    .range([0, width])
                    .domain([0, 100]);
     
            // Set chart container attribute, translate container to top, left margin       

            var chart = svg.attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr('class', 'chart')
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

            // append the rectangles for the bar chart
            for(var i = 0; i < keys.length; i++) {
                chart.selectAll(".item_bar")
                .data(data)
                .enter()
                .append("rect")
                .attr("class", keys[i])
                .attr("fill", notes[i].color)
                .attr("width", function(d) {return x(d[keys[i]]); } )
                .attr("y", function(d) { return y(d.label); })
                .attr("height", y.bandwidth());

            }

            // Build the x Axis
            chart.append("g")
                .attr("transform", "translate(" + 0 +"," + height +")")
                .attr('class', 'xAxis')
                .call(d3.axisBottom(x));

            var title = svg.append('g')
                .attr('class', 'title_group')
                .attr("transform", "translate(" + left + "," + 36 + ")")
                .append('text')
                .text(title);

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
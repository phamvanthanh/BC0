<template>
    <svg >

    </svg>
</template>
<script>
export default {
    props: ['data', 'barHeight', 'width', "keys", "colors"],

    mounted() {
        this.initStackedBarChart();
    },  
    methods: {
        initStackedBarChart() {
            var data = this.data,
            keys = this.keys,
            colors = this.colors,
            margin = {top: 20, right: 20, bottom: 30, left: 100},                      
            height = this.barHeight*this.data.length,

            // select svg chart container
            svg = d3.select("svg"),            
            // set y axis
            y = d3.scaleBand()
                    .range([height, 0])
                    .padding(0.2)
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
            margin.left = Math.round(maxw+20);

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
                .attr("fill", colors[i])
                .attr("width", function(d) {return x(d[keys[i]]); } )
                .attr("y", function(d) { return y(d.label); })
                .attr("height", y.bandwidth());

            }

            // Build the x Axis
            chart.append("g")
                .attr("transform", "translate(" + 0 +"," + height +")")
                .attr('class', 'xAxis')
                .call(d3.axisBottom(x));
        }
    }
}
</script>
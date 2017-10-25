<template>

    <svg  >

    </svg>

</template>
<script>
export default {
    props: ['datasets', 'width', 'height', 'yText', 'title'],

    data() {
        return {};

    },
    mounted() {
        this.initiateChart();
    },
    methods: {
        
        initiateChart() {
           
            var yText = this.yText,
            datasets = this.datasets,
            title = this.title,      
            left = 100,    
            margin = {top: 60, right: 20, bottom: 30, left: left},
            width = this.width - margin.left - margin.right,
            height = this.height - margin.top - margin.bottom;
            
            var parseTime = d3.timeParse("%Y-%m-%d %H:%M:%S");

            var maxs = datasets.map(function(e){
                var data = e.data;
                return data[data.length-1].x;
            });

            var mins = datasets.map(function(e){
                var data = e.data;
                return data[0].x;
            });

            var max_date = d3.max(maxs, function(d){
                return parseTime(d);
            });

            var min_date = d3.min(mins, function(d){
                return parseTime(d);
            });        
    

            var x = d3.scaleTime()
                    .rangeRound([0, width])
                    .domain([min_date, max_date]);

            var y = d3.scaleLinear()
                    .rangeRound([height, 0])
                    .domain([0, 100]);
            
            var line = d3.line()
                .x(function(d) { return x(parseTime(d.x)); })
                .y(function(d) { return y(d.y); });

            var svg = d3.select("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom),

            
            title = svg.append('g')
                .attr('class', 'title_group')
                .attr("transform", "translate(" + left + "," + 36 + ")")
                .append('text')
                .text(title),
                        
            g = svg.append("g")
                   .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
            
            g.append("g")
                 .attr("transform", "translate(0," + height + ")")
                 .call(d3.axisBottom(x));
              
                
                g.append("g")
                 .call(d3.axisLeft(y))
                 .append("text")
                 .attr("fill", "#000")
                 .attr("transform", "rotate(-90)")
                 .attr("y", 6)
                 .attr("dy", "0.71em")
                 .attr("text-anchor", "end")
                 .text(yText);

            
            for(var i = 0; i < datasets.length; i++) {
                var data = datasets[i].data;
                var color = datasets[i].color;
                g.append("path")
                .datum(data)
                .attr("fill", "none")
                .attr("stroke", color)
                .attr("stroke-linejoin", "round")
                .attr("stroke-linecap", "round")
                .attr("stroke-width", 1.5)
                .attr("d", line);
            }   

            var legend = svg.append("g")
                .attr("class", "legend_container")
                .attr("transform", "translate(" + (width + margin.left + margin.right) + "," + 20 + ")" );

            var legend_items = legend.selectAll('g.legend')
                .data(datasets)
                .enter()
                .append('g')
                .attr('class', 'legend')
                .attr('transform', function(d, i) { return  'translate(' + (150*i - 150*(datasets.length)) + ',' + 0 + ')'; });

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
                .text(function(d) { return d.label; });         
        }
    }
}
             
</script>
<template>

    <svg :width="width" :height="height">

    </svg>

</template>
<script>
export default {
    props: ['datasets', 'width', 'height', 'yText'],

    data() {
        return {};

    },
    mounted() {
        this.initiateChart();
    },
    methods: {
        
        initiateChart() {
           
            var title = this.yText,
            datasets = this.datasets,
            svg = d3.select("svg"),
            margin = {top: 20, right: 20, bottom: 30, left: 50},
            width = +svg.attr("width") - margin.left - margin.right,
            height = +svg.attr("height") - margin.top - margin.bottom,
            g = svg.append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");
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

                g.append("g")
                .attr("transform", "translate(0," + height + ")")
                .call(d3.axisBottom(x))
                .select(".domain")
                .remove();
                
                g.append("g")
                .call(d3.axisLeft(y))
                .append("text")
                .attr("fill", "#000")
                .attr("transform", "rotate(-90)")
                .attr("y", 6)
                .attr("dy", "0.71em")
                .attr("text-anchor", "end")
                .text(title);

            
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
        }
    }
}
             
</script>
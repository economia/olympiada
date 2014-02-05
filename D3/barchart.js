var margin = {
    top: 10,
    right: 10,
    bottom: 25,
    left: 50
};

var w = 670 - margin.left - margin.right;
var h = 480 - margin.top - margin.bottom;

var svg = d3.select("body")
    .append("svg")
    .attr("width", w + margin.left + margin.right)
    .attr("height", h + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var popisky = [
    "Období",
    "Města",
    "Vysílací práva",
    "Globální reklamní partneři",
    "Partneři v hostitelských zemích",
    "Prodej vstupenek",
    "Poplatky za použití olympijských motivů",
    "Celkem"
];

var color = d3.scale.ordinal()
    .range(['rgb(215,25,28)','rgb(253,174,97)','rgb(255,255,191)','rgb(171,221,164)','rgb(43,131,186)']);

/* load data */

d3.csv("../data/marketing-revenue.csv", function (dataset) {

    var yScale = d3.scale.linear()
            .range([h, 0]);

    var xScale = d3.scale.ordinal()
            .rangeRoundBands([0, w], 0.35);

    var yAxis = d3.svg.axis()
            .scale(yScale)
            .orient("left");

    var xAxis = d3.svg.axis()
            .scale(xScale);

    color.domain(d3.keys(dataset[0]).filter(function(key) { return key == "prava" || key == "partneri" || key ==  "hostitel" || key == "listky" || key == "licence"; }));

    dataset.forEach(function (d) {
        var y0 = 0;
        d.prijmy = color.domain().map(function (typ) { return { typ : typ, y0 : y0, y1 : y0 += +d[typ] }; });
    });

    dataset.sort(function(a, b) { return a.celkem - b.celkem; });

    xScale.domain(dataset.map(function (d) {return d.mesta}));
    yScale.domain([0, d3.max(dataset, function (d) {return d.celkem;})]);

    svg.append("g")
        .attr("class", "axis")
        .call(yAxis)
    .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("miliony dolarů");

    svg.append("g")
        .attr("class", "x axis")
        .call(xAxis)
        .attr("transform", "translate(0," + h + ")");


    var obdobi = svg.selectAll(".obdobi")
                    .data(dataset)
                    .enter()
                    .append("g")
                    .attr("class", "g")
                    .attr("transform", function (d) {return "translate(" + xScale(d.mesta) + ", 0)"; });

    console.log(dataset);

    obdobi.selectAll("rect")
        .data(function(d) { return d.prijmy; })
        .enter()
        .append("rect")
        .attr("width", xScale.rangeBand())
        .attr("y", function(d) { return yScale(d.y1); })
        .attr("height", function(d) { return yScale(d.y0) - yScale(d.y1); })
        .style("fill", function(d) { return color(d.typ); });


    /* insert elements 



    svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function(d, i) {
            return xScale(d.mesta);
        })
        .attr("width", xScale.rangeBand())
        .attr("y", function(d) {   
            return yScale(d.celkem);
        })
        .attr("height", function(d) {
            return h - yScale(d.celkem);
        })
        .attr("fill", "skyblue")
        .attr("stroke", "black")
        .attr("stroke-width", 0.5)*/

});
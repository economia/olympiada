var margin = {
    top: 10,
    right: 10,
    bottom: 10,
    left: 10
};

var w = 670 - margin.left - margin.right;
var h = 480 - margtin.top - margin.bottom;



var svg = d3.select("body")
    .append("svg")
    .attr("width", w)
    .attr("height", h);

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

/* load data */

d3.csv("../data/marketing-revenue.csv", function(dataset) {

    var yScale = d3.scale.linear()
        .domain([0, d3.max(dataset, function(d, i) {
            return d.celkem;
        })])
        .range([padding, h - padding]);

    /* insert elements */
    svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function(d, i) {
            return i * w / dataset.length;
        })
        .attr("y", function(d) {
            return h - yScale(d.celkem);
        })
        .attr("width", w / dataset.length - 30)
        .attr("height", function(d) {
            return yScale(d.celkem);
        })
        .attr("fill", "skyblue")
        .attr("stroke", "black")
        .attr("stroke-width", 3)
});
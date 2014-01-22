var margin = {
    top: 20,
    right: 20,
    bottom: 20,
    left: 20
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

/* load data */

d3.csv("../data/marketing-revenue.csv", function(dataset) {

    var yScale = d3.scale.linear()
        .domain([0, d3.max(dataset, function(d, i) {
            return d.celkem;
        })])
        .range([0, h]);

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
        .attr("width", w / dataset.length - 60)
        .attr("height", function(d) {
            return yScale(d.celkem);
        })
        .attr("fill", "skyblue")
        .attr("stroke", "black")
        .attr("stroke-width", 3)
});
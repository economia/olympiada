var w = 670;
var h = 480;

var svg = d3.select("body")
    .append("svg")
    .attr("width", w)
    .attr("height", h)

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

    /* insert elements */
    svg.selectAll("rect")
        .data(dataset)
        .enter()
        .append("rect")
        .attr("x", function(d, i) {
            return i * w / dataset.length;
        })
        .attr("y", function(d) {
            return h - d.celkem / 20;
        })
        .attr("width", w / dataset.length - 1)
        .attr("height", function(d, i) {
            return parseFloat(d.celkem / 20);
        })
});
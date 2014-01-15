var data;

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

d3.csv("../data/marketing-revenue.csv", function(d) {
    data = d;
});

/* insert elements */
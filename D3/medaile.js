var margin = {
    top: 10,
    right: 10,
    bottom: 10,
    left: 10
};

var w = 970 - margin.left - margin.right;
var h = 620 - margin.top - margin.bottom;

var svg = d3.select("body")
    .append("svg")
    .attr("width", w + margin.left + margin.right)
    .attr("height", h + margin.top + margin.bottom)
    .append("g")
	.attr("transform", "translate(" + margin.left + "," + margin.top + ")");

// load data

d3.csv("../data/medailiste.csv", function(data) {

	svg.selectAll("rect")
        .data(data)
        .enter()
        .append("rect")
        .attr("width", "30px")
        .attr("height", "4px")
	    .attr("y", function (d, i) { return i  % 122 * 5 })
	    .attr("x", function (d, i) { return ( Math.floor (i / 122) ) * 32 } )
	    .attr("fill", function (d) {
	    	if (d.medaile == "zlato") {return "gold"}
	    	else if (d.medaile == "stříbro") {return "silver"}
	    	else if (d.medaile == "bronz") {return "darkgoldenrod"}
	    })
	    .append("title")
	    .text(function (d) { return d.rok + " " + d.stat + " " + d.jmena + " " + d.sport + " " + d. medaile });

});
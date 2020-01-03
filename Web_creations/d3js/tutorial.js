/* Intro D3JS */
const data = [4, 8, 15, 16, 23, 42]

const x = d3.scaleLinear()
    .domain([0, d3.max(data)])
    .range([0, 420])

d3.select("div.chart")
    .selectAll("div")
    .data(data)
    .enter()
    .append("div")
    .style("width", d =>  x(d) + "px")
    .text(d => d)

/* D3JS & SVG */
const width = 420, barHeight = 20

const y = d3.scaleLinear().range([0, width])

const chart = d3.select("svg.chart")
    .attr("width", width)

d3.tsv("tsv_data.tsv").then(tsv_data => {

    tsv_data.forEach(el => {
        el.value = parseInt(el.value)
    })

    y.domain([0, d3.max(tsv_data, d => d.value)])

    chart.attr("height", barHeight * tsv_data.length)

    const bar = chart.selectAll("g")
    .data(tsv_data)
    .enter()
    .append("g")
    .attr("transform", (d, i) => "translate(0," + i * barHeight + ")")

    bar.append("rect")
    .attr("width", d => y(d.value))
    .attr("height", barHeight - 1)

    bar.append("text")
    .attr("x", d => y(d.value) - 3)
    .attr("y", barHeight / 2)
    .attr("dy", ".35em")
    .text(d => d.value)
})



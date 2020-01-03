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
        el.value = +el.value
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

/* D3JS & SVG - Orientation */

const margin = {top: 20, right: 30, bottom: 30, left: 40},
    width_col = 960 - margin.left - margin.right,
    height_col = 500 - margin.top - margin.bottom

const x2 = d3.scaleBand().rangeRound([0, width_col])

const y2 = d3.scaleLinear().range([height_col, 0])

var xAxis = d3.axisBottom(x2)

const chart2 = d3.select("svg.chart2")
    .attr("width", width_col + margin.left + margin.right)
    .attr("height", height_col + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height_col + ")")
    .call(xAxis);

d3.tsv("tsv_data.tsv").then(data => {
    x2.domain(data.map(d => d.name))
    y2.domain([0, d3.max(data, d => d.value)])

    const barWidth2 = width_col / data.length

    const bar2 = chart2.selectAll("g")
            .data(data)
            .enter()
            .append("g")
            .attr("transform", (d, i) => "translate(" + x2(d.name) + ",0)")

    bar2.append("rect")
        .attr("y", d => y2(d.value))
        .attr("height", d => height_col - y2(d.value))
        .attr("width", x2.bandwidth())

    bar2.append("text")
        .attr("x", x2.bandwidth() / 2)
        .attr("y", d => y2(d.value) + 3)
        .attr("dy", ".75em")
        .text(d => d.value)
})

const type = d => {
  d.value = + d.value
  return d
}


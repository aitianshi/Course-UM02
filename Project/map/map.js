
mapboxgl.accessToken = 'pk.eyJ1IjoiYWl0aWFuIiwiYSI6ImNrMzQ2Y2hpaDB0bWczbW9iaHU1bWFtYjgifQ.3PgxuursXG4olgBz6O_l8g'
			
// China centered bounds
var bounds = [
	[ 69.171776, 16.627344], 
	[136.980085, 54.238221]
]
			
var map = new mapboxgl.Map({
	container: 'map',
	style: 'mapbox://styles/mapbox/dark-v10',
	// style: 'mapbox://styles/mapbox/light-v10',
	zoom: 0,
	maxBounds: bounds,
	boxZoom: true,
	keyboard: true,
	doubleClickZoom: true
})
/*
map.addControl(
	new mapboxgl.NavigationControl(),
	new mapboxgl.FullscreenControl()
)
*/
const aqi1 = ['<', ['get', 'aqi'], 50];
const aqi2 = ['all', ['>=', ['get', 'aqi'], 51], ['<', ['get', 'aqi'], 100]];
const aqi3 = ['all', ['>=', ['get', 'aqi'], 101], ['<', ['get', 'aqi'], 150]];
const aqi4 = ['all', ['>=', ['get', 'aqi'], 151], ['<', ['get', 'aqi'], 200]];
const aqi5 = ['all', ['>=', ['get', 'aqi'], 201], ['<', ['get', 'aqi'], 300]];
const aqi6 = ['>=', ['get', 'aqi'], 301];

const colors = ['#fed976', '#feb24c', '#fd8d3c', '#fc4e2a', '#e31a1c'];

map.on("load", () => {
	map.addSource("airquality", {
	  type: "geojson",
	  data: "http://0.0.0.0:8000/Documents/UM02/Course-UM02/Project/data/dataset.geojson"
	})
  
	map.addLayer({
		id: "aqi-heat",
		type: "heatmap",
		source: "airquality",
		maxzoom: 9,
		paint: {
			'heatmap-weight': {
				property: 'aqi',
				type: 'exponential',
				stops: [
				  [1, 0],
				  [300, 1]
				]
			},
		  // Increase the heatmap color weight weight by zoom level
		  // heatmap-intensity is a multiplier on top of heatmap-weight
		  // "heatmap-intensity": ["interpolate", ["linear"], ["zoom"], 0, 1, 9, 3],

		  // Color ramp for heatmap.  Domain is 0 (low) to 1 (high).
		  // Begin color ramp at 0-stop with a 0-transparancy color
		  // to create a blur-like effect.
		  'heatmap-color': [
			'interpolate',
			['linear'],
			['get','aqi'],
			0, 'rgba(168,226,96,0)',
			51, 'rgb(254,212,80)',
			101, 'rgb(253,155,80)',
			151, 'rgb(254,108,105)',
			201, 'rgb(167,125,187)',
			301, 'rgb(165,117,133)',
		  ],
		  'heatmap-radius': {
			stops: [
			  [11, 15],
			  [15, 20]
			]
		  },
		  'heatmap-opacity': {
			default: 1,
			stops: [
			  [14, 1],
			  [15, 0]
			]
		  },
		}
	  },
	  "waterway-label"
	)
  })  

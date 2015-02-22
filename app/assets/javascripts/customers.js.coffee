$(document).ready ->
map = L.mapbox.map('map', 'tamarochka.l9dm5in5').setView([45.52086, -122.679523], 14)
$.ajax
dataType: 'text'
url: 'customers/index.json'
success: (data) ->
geojson = $.parseJSON(data)
map.featureLayer.setGeoJSON(geojson)

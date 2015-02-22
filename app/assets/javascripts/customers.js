$(document).ready(function() {
  L.mapbox.accessToken = "pk.eyJ1IjoidGFtYXJvY2hrYSIsImEiOiJPTjJjR0RZIn0.IbDwUsbp_h2MY7WRN9jSBw";
  var map = L.mapbox.map('map', 'tamarochka.l9dm5in5').setView([39.606810, -116.929677], 7);
  var myLayer = L.mapbox.featureLayer().addTo(map);
  $.ajax({
    dataType: 'text',
    url: '/custmers.json',
    success: function(data) {
      var geojson;
      geojson = $.parseJSON(data);
      return myLayer.setGeoJSON(geojson);
    }
  });
});

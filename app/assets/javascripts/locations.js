
// var marker;
// function createMarker(coords, map, title) {
//     marker = new google.maps.Marker({
//         position: coords,
//         map: map,
//         title: title
//     });
// }
//
// var geocoding = new google.maps.Geocoder();
// $("#submit_button_geocoding").click(function() {
//     codeAddress(geocoding);
// });
// $("#submit_button_reverse").click(function() {
//     codeLatLng(geocoding);
// });
var wine = {};
var liquor = {};
var threeTwo = {};
var map, infoWindow, locations;
function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 40.7608, lng: -111.8910},
        zoom: 14
    });
    infoWindow = new google.maps.InfoWindow;

    //trying html5 geolocation
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            document.cookie = "lat=" + pos.lat;
            document.cookie = "lng=" + pos.lng;
            infoWindow.setPosition(pos);
            infoWindow.setContent('Look at you');
            infoWindow.open(map);
            map.setCenter(pos);
            getAllLocations(pos);

        }, function() {
            handleLocationError(true, infoWindow, map.getCenter());
        });
    } else {
        handleLocationError(false, infoWindow, map.getCenter());
    }
}
function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ? 'Error: Geolocation service failed' : 'Error: Your browser does not support geolocation.')
    infoWindow.open(map);
}

function getLocations(pos) {
  $.ajax({
    beforeSend: function(xhrObj){
                xhrObj.setRequestHeader("Content-Type","application/json");
                xhrObj.setRequestHeader("Accept","application/json");
        },
    method: 'GET',
    url: 'locations/get_locations.rb',
    data: pos,
    dataType: "json",
    success: function(result) {
      beer = _.filter(result, 'beer');
      wine = _.filter(result, 'wine');
      liquor = _.filter(result, 'liquor');
        _.forEach(beer, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'B');
        });
        _.forEach(wine, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'W');
        });
        _.forEach(liquor, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'L');
        });

    }
  })
}

function getBeer() {
    $.ajax({
        method: 'GET',
        url: 'locations/get_beer.rb',
        dataType: 'json',
        success: function(result) {
            beer = result;
            _.forEach(beer, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'B');
        });
        }
    });
}

function getAllLocations() {
    $.ajax({
        beforeSend: function(xhrObj){
                xhrObj.setRequestHeader("Content-Type","application/json");
                xhrObj.setRequestHeader("Accept","application/json");
        },
    method: 'GET',
    url: 'locations/get_all_locations.rb',
    success: function(result) {
        locations = result;
        beer = _.filter(locations, 'beer');
      wine = _.filter(locations, 'wine');
      liquor = _.filter(locations, 'liquor');
        _.forEach(beer, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'B');
        });
        _.forEach(wine, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'W');
        });
        _.forEach(liquor, function(value) {
            createMarker({lat: value.latitude, lng: value.longitude}, map, value.name, 'L');
        });
    }
    })
}
function createMarker(coords, map, title, label) {
  marker = new google.maps.Marker({
    position: coords,
    map: map,
    title: title,
    label: label
  })
}

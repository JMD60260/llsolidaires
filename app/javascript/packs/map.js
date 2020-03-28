import GMaps from 'gmaps/gmaps.js';
// import { initAutocomplete } from '../components/autocomplete';


// const mapElement = document.getElementById('map');
// if (mapElement) {
//   const map = new GMaps({
//     el: '#map',
//     lat: 48.8534,
//     lng: 2.3488,
//     zoom:12
//   });

//   const markers = JSON.parse(mapElement.dataset.markers);
//   map.addMarkers(markers);
//   if (markers.length === 0) {
//     map.setZoom(12);
//   } else if (markers.length === 1) {
//     map.setCenter(markers[0].lat, markers[0].lng);
//     map.setZoom(5);
//   } else {
//     map.fitLatLngBounds(markers);
//   }
// }


function initAutocomplete() {
  const map = new GMaps({
    el: '#map',
    lat: 48.8534,
    lng: 2.3488,
    zoom: 12
  });

  // Create the search box and link it to the UI element.
  var input = document.getElementById('SearchBar');
  var searchBox = new google.maps.places.SearchBox(input);
  console.log(searchBox)
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function () {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function () {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }

    // Clear out the old markers.
    markers.forEach(function (marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function (place) {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
}

initAutocomplete();

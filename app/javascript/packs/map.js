import GMaps from 'gmaps/gmaps.js';

require('google-maps');

function initAutocomplete() {
  const map = new GMaps({
    el: '#map',
    lat: 48.8534,
    lng: 2.3488,
    zoom: 7
  });

  // Create the search box and link it to the UI element.
  var input = document.getElementById('SearchBar');

  var searchBox = new google.maps.places.SearchBox(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function () {
    searchBox.setBounds(map.getBounds());
  });


  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.

  let query
  searchBox.addListener('submit', function () {
    var places = searchBox.getPlaces();
    console.log(places)
    query = places[0].formatted_address
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
    let target = document.getElementById('SearchBar');
    target.removeAttribute('value');
    target.setAttribute('value', `${query}`);
  });


  let flats = document.getElementById('map').getAttribute('data-markers');

  if (flats){
     flats = flats.replace('[', '');
     flats = flats.replace(']', '');
     flats = flats.split('},');

     let value
     let flatarray = []
     for (let i = 0; i < flats.length; i++) {
      if (flats.length === 0) {
        value = flats[0] + '}';
      } else if (i != flats.length - 1) {
        value = flats[i] + '}';
       } else {
         value = flats[i];
       }

       let json = JSON.parse(value)
       if(typeof(json) === "object"){
           map.addMarker({
             lat: json.lat,
             lng: json.lng,
           });
       }
       console.log(value)
     }
  }
}

initAutocomplete()


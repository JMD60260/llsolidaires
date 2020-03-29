require('google-maps');

function initAutocomplete() {
  console.log("coucou");
    const map = new GMaps({
      el: '#map',
      lat: 0,
      lng: 0
    });
  console.log("1")
  // Create the search box and link it to the UI element.
  var input = document.getElementById('SearchBar');
  console.log("2")
  var searchBox = new google.maps.places.SearchBox(input);
  // console.log("3")
  // let arrayMap = {
  //   'google.maps.ControlPosition.TOP_LEFT': input
  // }
  // console.log("4")
  // map.controls.push(arrayMap);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function () {
    searchBox.setBounds(map.getBounds());
  });
  console.log("5")

  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function () {
    var places = searchBox.getPlaces();
    if (places.length == 0) {
      return;
    }
    console.log("6")
    // Clear out the old markers.
    markers.forEach(function (marker) {
      marker.setMap(null);
    });
    markers = [];
    console.log("7")
    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    console.log("8")
    places.forEach(function (place) {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      console.log("9")
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };
      console.log("10")

      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));
      console.log("11")
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

initAutocomplete()

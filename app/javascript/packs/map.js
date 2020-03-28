import GMaps from 'gmaps/gmaps.js';
import { autocomplete } from '../components/autocomplete';


const mapElement = document.getElementById('map');
if (mapElement) {
  const map = new GMaps({
    el: '#map',
    lat: 48.8534,
    lng: 2.3488,
  });
  const markers = JSON.parse(mapElement.dataset.markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(5);
  } else {
    map.fitLatLngBounds(markers);
  }
}


autocomplete();

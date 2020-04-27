import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.pk.eyJ1IjoicHdlc3RtYW4iLCJhIjoiY2s5aWdwa2F2MDFrYTNrcGh2bWRjYTVuZiJ9.BuMV46ODfPwtl2P-JiDbmg;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
  }
};

export { initMapbox };
const mapElement = document.getElementById("map")

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey
  return new mapboxgl.Map({
    container: "map",
    style: "mapbox://styles/mapbox/streets-v11",
    center: [9.194691, 45.471711],
    zoom: 22,
  })
}

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow)

    const element = document.createElement("div")
    element.className = "marker"
    element.style.backgroundSize = "contain"
    element.style.width = "25px"
    element.style.height = "25px"

    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map)
  })
}

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds()
  markers.forEach((marker) => bounds.extend([marker.lng, marker.lat]))
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 })
}

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap()
    console.log(mapElement)
    const markers = JSON.parse(mapElement.dataset.markers)
    addMarkersToMap(map, markers)
    fitMapToMarkers(map, markers)
  }
}

export { initMapbox }

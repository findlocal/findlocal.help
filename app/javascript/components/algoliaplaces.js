const algoliaPlaces = function() {
const for_input = document.querySelector('#task_location')
if (for_input) {
var places = require('places.js');
var placesAutocomplete = places({
  appId: 'plQV4XVJ2NEK',
  apiKey: '1e8728c06104453bdd9931929be08b81',
  container: document.querySelector('#task_location')
});
}
}
export { algoliaPlaces };
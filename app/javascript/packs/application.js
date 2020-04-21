// Start Rails services
require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// Packages
import 'bootstrap'
import '../components' // no need to specify the /index in js, it's automatic
import { autocompleteSearch } from '../components/autocomplete.js';
import { algoliaPlaces } from '../components/algoliaplaces.js';



//const algoliaPlaces = function() {
//const for_input = document.querySelector('#task_location')
// var places = require('places.js');
// var placesAutocomplete = places({
//   appId: 'plQV4XVJ2NEK',
//   apiKey: '1e8728c06104453bdd9931929be08b81',
//   container: document.querySelector('#task_location')
// });
// }
// const test = document.querySelector('#task_location')
// if (test) { 
// 	algoliaPlaces()
// }
algoliaPlaces()
autocompleteSearch()


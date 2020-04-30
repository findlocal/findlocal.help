// Start Rails services
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// ----------------------------------------------------
// Note: ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE CUSTOM JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap"

// Internal imports
import {
  initDatepicker,
  initTooltips,
  updateNavbarOnScroll,
  updateNavbarWhiteOnScroll,
} from "../components"
import { autocompleteSearch } from "../components/autocomplete.js"
import { autocompleteSearchNew } from "../components/autocomplete2.js"
import { algoliaPlaces } from "../components/algoliaplaces.js"

document.addEventListener("turbolinks:load", () => {
  // Call all the custom functions here or they won't load correctly:

  initDatepicker()
  initTooltips()
  updateNavbarOnScroll()
  updateNavbarWhiteOnScroll()
  algoliaPlaces()
  autocompleteSearch()
  autocompleteSearchNew()
})

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

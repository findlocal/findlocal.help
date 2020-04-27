// Start Rails services
require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// ----------------------------------------------------
// Note: ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE CUSTOM JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import 'bootstrap'

// Internal imports
import { initDatepicker, initTooltips, updateNavbarOnScroll } from '../components'

document.addEventListener('turbolinks:load', () => {
  // Call all the custom functions here or they won't load correctly:
  initDatepicker()
  initTooltips()
  updateNavbarOnScroll()
})

import { initMapbox } from '../packs/map.js';

document.addEventListener('turbolinks:load', () => {
  initMapbox();
})

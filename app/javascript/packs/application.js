// Start Rails services
require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// Packages
import 'bootstrap'

// Required below for the datetimepicker - to be left commented per instructions
//= require moment

//= require bootstrap-datetimepicker
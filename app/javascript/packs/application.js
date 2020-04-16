// Start Rails services
require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

// Packages
import 'bootstrap'
import '../components' // no need to specify the /index in js, it's automatic

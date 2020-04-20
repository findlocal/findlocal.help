import $ from 'jquery'

// Enable Bootstrap tooltips on all website -> https://getbootstrap.com/docs/4.0/components/tooltips/#example-enable-tooltips-everywhere
const initTooltips = () => {
  $(() => {
    $('[data-toggle="tooltip"]').tooltip()
  })
}

export default initTooltips

const updateNavbarWhiteOnScroll = () => {
  const navbar = document.querySelector('.navbar-local-help-white-pages')

  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= navbar.scrollHeight) {
        navbar.classList.add('navbar-local-help-green')
      } else {
        navbar.classList.remove('navbar-local-help-green')
      }
    })
  }
}


export default updateNavbarWhiteOnScroll

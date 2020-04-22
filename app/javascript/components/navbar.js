const updateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-local-help')

  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= navbar.scrollHeight) {
        navbar.classList.add('navbar-local-help-white')
      } else {
        navbar.classList.remove('navbar-local-help-white')
      }
    })
  }
}

export default updateNavbarOnScroll

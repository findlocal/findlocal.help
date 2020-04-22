const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-localhelp');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 100) {
        // if (window.scrollY >= window.innerHeight) {

        navbar.classList.add('navbar-localhelp-white');
      } else {
        navbar.classList.remove('navbar-localhelp-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };

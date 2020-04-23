const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-localhelp');
  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 100) {
        // if (window.scrollY >= window.innerHeight) {
        console.log('hello')
        navbar.classList.add('navbar-localhelp-white');
        console.log('event')
      } else {
        navbar.classList.remove('navbar-localhelp-white');
      }
    });
  }
};

export { initUpdateNavbarOnScroll };

/**
* Template Name: Bikin - v4.7.0
* Template URL: https://bootstrapmade.com/bikin-free-simple-landing-page-template/
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/
(function () {
  "use strict";


  // Table Darstellung laut
  // https://datatables.net/extensions/fixedheader/examples/integration/responsive-bootstrap.html 
  $(document).ready(function () {
    var table = $('#BlogbeitraegeTable').DataTable({
      responsive: true
    });
  });

  // BlogbeitraegeTable, blogbeitraege
  $("#meinSwitch").on("change", function () {

    if (this.checked == true) {
      $("#Blog").show()
      $("#blogbeitraege").hide()
    }
    else {
      $("#Blog").hide()
      $("#blogbeitraege").show()
    }
  })

  // adding a Watch to see if font has changed 
  $("#themeselect").on("change", function () {
    //checking which is selected and setting the Fontfamily accordingly
    var value = $('#themeselect :selected').val();
    var fontFamilyy = "";
    switch (value) {
      case "1":
        fontFamilyy = "Open Sans";
        break;
      case "2":
        fontFamilyy = "Comic Sans MS";
        break;
      case "3":
        fontFamilyy = "Arial";
        break;
    }

    // iterating over all h2s and changing there Font Family
    var h2s = document.getElementsByTagName('h2');
    for (var i = 0, max = h2s.length; i < max; i++) {
      h2s[i].style.fontFamily = fontFamilyy;
    }
  })

  // adding a Watch to see if ImgClass has changed 
  $("#imgClassSelect").on("change", function () {
    //checking which is selected and setting the Fontfamily accordingly
    var value = $('#imgClassSelect :selected').val();
  
      // iterating over all h2s and changing there Font Family
      var imgs = document.getElementsByTagName('img');
      for (var i = 0, max = imgs.length; i < max; i++) {
        if(value == "1"){
          imgs[i].className = "border border-danger";
        }
        if(value == "2"){
          imgs[i].className =  "rounded"; 
        }
        if(value == "3"){
          imgs[i].className = "rounded-circle";
        }
      }
    })

  // changing the color of h2s on change from the color picker
  $('#colorIdH2').on("change", function () {
    var temp = document.getElementById('colorId').value;

    var h2arr = document.getElementsByTagName('h2');
    for (let index = 0; index < h2arr.length; index++) {
      h2arr[index].style.color = temp;
    }
    document.getElementsByTagName('h2').style.color = temp;
  })

    // changing the color of links on change from the color picker
    $('#colorIdlinks').on("change", function () {
      var temp = document.getElementById('colorId').value;
  
      var link = document.getElementsByTagName('a');
      for (let index = 0; index < link.length; index++) {
        link[index].style.color = temp;
      }
      document.getElementsByTagName('a').style.color = temp;
    })

  /**
   * Easy selector helper function
   */
  const select = (el, all = false) => {
    el = el.trim()
    if (all) {
      return [...document.querySelectorAll(el)]
    } else {
      return document.querySelector(el)
    }
  }

  /**
   * Easy event listener function
   */
  const on = (type, el, listener, all = false) => {
    let selectEl = select(el, all)
    if (selectEl) {
      if (all) {
        selectEl.forEach(e => e.addEventListener(type, listener))
      } else {
        selectEl.addEventListener(type, listener)
      }
    }
  }

  /**
   * Easy on scroll event listener 
   */
  const onscroll = (el, listener) => {
    el.addEventListener('scroll', listener)
  }

  /**
   * Navbar links active state on scroll
   */
  let navbarlinks = select('#navbar .scrollto', true)
  const navbarlinksActive = () => {
    let position = window.scrollY + 200
    navbarlinks.forEach(navbarlink => {
      if (!navbarlink.hash) return
      let section = select(navbarlink.hash)
      if (!section) return
      if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
        navbarlink.classList.add('active')
      } else {
        navbarlink.classList.remove('active')
      }
    })
  }
  window.addEventListener('load', navbarlinksActive)
  onscroll(document, navbarlinksActive)

  /**
   * Scrolls to an element with header offset
   */
  const scrollto = (el) => {
    let header = select('#header')
    let offset = header.offsetHeight

    let elementPos = select(el).offsetTop //wie weit is des gesuche element von oben weg
    window.scrollTo({
      top: elementPos - offset, // - offset um unter der nav bar zu sein 
      behavior: 'smooth'
    })
  }

  /**
   * Back to top button
   */
  let backtotop = select('.back-to-top')
  if (backtotop) {
    const toggleBacktotop = () => {
      if (window.scrollY > 100) {
        backtotop.classList.add('active')
      } else {
        backtotop.classList.remove('active')
      }
    }
    window.addEventListener('load', toggleBacktotop)
    onscroll(document, toggleBacktotop)
  }

  /**
   * Mobile nav toggle
   */
  on('click', '.mobile-nav-toggle', function (e) {
    select('#navbar').classList.toggle('navbar-mobile')
    this.classList.toggle('bi-list')
    this.classList.toggle('bi-x')
  })

  /**
   * Mobile nav dropdowns activate
   */
  on('click', '.navbar .dropdown > a', function (e) {
    if (select('#navbar').classList.contains('navbar-mobile')) {
      e.preventDefault()
      this.nextElementSibling.classList.toggle('dropdown-active')
    }
  }, true)

  /**
   * Scrool with ofset on links with a class name .scrollto
   */
  on('click', '.scrollto', function (e) {
    if (select(this.hash)) {
      e.preventDefault()

      let navbar = select('#navbar')
      if (navbar.classList.contains('navbar-mobile')) {
        navbar.classList.remove('navbar-mobile')
        let navbarToggle = select('.mobile-nav-toggle')
        navbarToggle.classList.toggle('bi-list')
        navbarToggle.classList.toggle('bi-x')
      }
      scrollto(this.hash)
    }
  }, true)

  /**
   * Scroll with ofset on page load with hash links in the url
   */
  window.addEventListener('load', () => {
    if (window.location.hash) {
      if (select(window.location.hash)) {
        scrollto(window.location.hash)
      }
    }
  });

  /**
   * Preloader
   */
  let preloader = select('#preloader');
  if (preloader) {
    window.addEventListener('load', () => {
      preloader.remove()
    });
  }

  /**
   * Porfolio isotope and filter
   */
  window.addEventListener('load', () => {
    let portfolioContainer = select('.portfolio-container');
    if (portfolioContainer) {
      let portfolioIsotope = new Isotope(portfolioContainer, {
        itemSelector: '.portfolio-item'
      });

      let portfolioFilters = select('#portfolio-flters li', true);

      on('click', '#portfolio-flters li', function (e) {
        e.preventDefault();
        portfolioFilters.forEach(function (el) {
          el.classList.remove('filter-active');
        });
        this.classList.add('filter-active');

        portfolioIsotope.arrange({
          filter: this.getAttribute('data-filter')
        });
        portfolioIsotope.on('arrangeComplete', function () {
          AOS.refresh()
        });
      }, true);
    }

  });

  /**
   * Initiate portfolio lightbox 
   */
  const portfolioLightbox = GLightbox({
    selector: '.portfolio-lightbox'
  });

  /**
   * Portfolio details slider
   */
  new Swiper('.portfolio-details-slider', {
    speed: 400,
    loop: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false
    },
    pagination: {
      el: '.swiper-pagination',
      type: 'bullets',
      clickable: true
    }
  });

  /**
   * Testimonials slider
   */
  new Swiper('.testimonials-slider', {
    speed: 600,
    loop: true,
    autoplay: {
      delay: 5000,
      disableOnInteraction: false
    },
    slidesPerView: 'auto',
    pagination: {
      el: '.swiper-pagination',
      type: 'bullets',
      clickable: true
    },
    breakpoints: {
      320: {
        slidesPerView: 1,
        spaceBetween: 20
      },

      1200: {
        slidesPerView: 3,
        spaceBetween: 20
      }
    }
  });

  /**
   * Animation on scroll
   */
  window.addEventListener('load', () => {
    AOS.init({
      duration: 1000,
      easing: 'ease-in-out',
      once: true,
      mirror: false
    })
  });
})()
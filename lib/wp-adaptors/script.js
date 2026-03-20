function ready () {
  'use strict'

  // open mobile menu
  const bodyTag = document.getElementsByTagName('body')[0]
  const mobileMenuBtn = document.getElementById('header-modal-anchor-toggle')
  const offCanvasMenu = document.getElementById('header-modal-off-canvas')
  mobileMenuBtn.addEventListener('click', function() {
    if (offCanvasMenu.classList.contains('x-active')) {
      offCanvasMenu.classList.remove('x-active')
      bodyTag.classList.remove('x-body-scroll-disabled')
    } else {
      offCanvasMenu.classList.add('x-active')
      bodyTag.classList.add('x-body-scroll-disabled')
    }
  })

  // close mobile menu
  const closeBtn = document.querySelector('[data-x-toggle-close]')
  closeBtn.addEventListener('click', function(e) {
    e.preventDefault()
    if (offCanvasMenu.classList.contains('x-active')) {
      offCanvasMenu.classList.remove('x-active')
      bodyTag.classList.remove('x-body-scroll-disabled')
    }
  })

}
document.addEventListener('DOMContentLoaded', ready)

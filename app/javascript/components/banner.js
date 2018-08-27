import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('#banner-typed-text', {
    strings: ["Flavours", "Essential Oils"],
    typeSpeed: 50,
    loop: true
  });
}

export { loadDynamicBannerText };

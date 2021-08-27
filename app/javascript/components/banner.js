import Typed from "typed.js";

const loadDynamicBannerText = () => {
  new Typed("#banner-typed-text", {
    strings: ["Welcome to Your Movie Watchlist!", "Add a New List!"],
    typeSpeed: 50,
    loop: true,
  });
};

export { loadDynamicBannerText };

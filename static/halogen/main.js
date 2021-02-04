import { main } from "./output/Main/index.js";

// Initialize PureScript on page load
window.addEventListener("load", () => {
  main();
});

// Initialize PureScript on Turbolinks transition
document.addEventListener("turbolinks:load", () => {
  main();
});

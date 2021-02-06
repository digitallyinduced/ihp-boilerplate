"use strict";
import { Elm } from "./Main.elm";

// Runs Elm on all elm Nodes in the DOM
function initializeWidgets() {
  const elmNodes = document.querySelectorAll(".elm");
  elmNodes.forEach((node) => {
    const app = Elm.Main.init({
      node
    });
    // Write ports below this comment
  });
}

// Initializes Elm on page load
window.addEventListener("load", (event) => {
  initializeWidgets();
});

// Initializes Elm on Turbolinks transition
document.addEventListener("turbolinks:load", (e) => {
  initializeWidgets();
});
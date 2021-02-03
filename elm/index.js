"use strict";
import { Elm } from "./Main.elm";

// Run Elm on all elm Nodes
function initializeWidgets() {
  const elmNodes = document.querySelectorAll(".elm");
  elmNodes.forEach((node) => {
    const app = Elm.Main.init({
      node,
      flags: getFlags(node.dataset.flags),
    });
    // Initialize ports below this line
  });
}

// Parse the JSON from IHP or just pass null if there is no flags data
function getFlags(data) {
  return data ? JSON.parse(data) : null;
}

// Initialize Elm on page load
window.addEventListener("load", (event) => {
  initializeWidgets();
});

// Initialize Elm on Turbolinks transition
document.addEventListener("turbolinks:load", (e) => {
  initializeWidgets();
});
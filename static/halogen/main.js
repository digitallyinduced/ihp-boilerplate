import { main } from "./output/Main/index.js";

document.addEventListener("ihp:load", () => {
  if (window.PureScriptInitialized) return;
  main();
  window.PureScriptInitialized = true;
});

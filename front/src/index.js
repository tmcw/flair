import { Elm } from "./Main.elm";

const storedState = localStorage.getItem("front");
const startingState = storedState ? JSON.parse(storedState) : null;

const app = Elm.Main.init({
  node: document.getElementById("root")
});

console.log("app", JSON.stringify(app));

/*
app.ports.setStorage.subscribe(function(state) {
  localStorage.setItem("front", JSON.stringify(state));
});
*/

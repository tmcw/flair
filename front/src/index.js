import { Elm } from "./Main.elm";

const app = Elm.Main.init({
  node: document.getElementById("root")
});

document.body.style.transition = "background, color 600ms ease-in-out";
document.body.style.transition = "background 600ms ease-in-out";

app.ports.setDark.subscribe(dark => {
  if (dark) {
    document.body.style.background = "#3c3c3c";
    document.body.style.color = "rgb(229, 227, 224)";
  } else {
    document.body.style.background = "rgb(249, 247, 244)";
    document.body.style.color = "#000";
  }
});

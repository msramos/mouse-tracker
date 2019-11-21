import css from "../css/app.css";

import "phoenix_html";
import { channel } from "./socket";

const element = document.getElementById("tracked-square");
const mousePos = document.getElementById("mouse-position");
const clearBtn = document.getElementById("clear-content");
const canvas = document.getElementById("heatmap-canvas");
const ctx = canvas.getContext("2d");

// canvas settings
ctx.globalAlpha = 0.5;
ctx.lineWidth = 5;
ctx.strokeStyle = "#003300";
ctx.fillStyle = "green";

let diffX = element.offsetLeft;
let diffY = element.offsetTop;

window.onresize = () => {
  diffX = element.offsetLeft;
  diffY = element.offsetTop;
};

// Configure tracked square
element.onmousemove = event => {
  let point = {
    x: event.clientX - diffX,
    y: event.clientY - diffY
  };
  mousePos.innerHTML = `${point.x}, ${point.y}`;
  channel.push("position", point);
};

element.onclick = event => {
  let point = {
    x: event.clientX - diffX,
    y: event.clientY - diffY
  };
  channel.push("click", point);
};

element.onmouseleave = () => {
  mousePos.style.display = "none";
};

element.onmouseenter = () => {
  mousePos.style.display = "block";
};

// Configure heatmap
channel.on("event:position", ({ x, y }) => {
  ctx.fillRect(x-2, y-2, 4, 4);
});

channel.on("event:click", ({x, y}) => {
  ctx.beginPath();
  ctx.arc(x, y, 5, 0, 2 * Math.PI, false);
  ctx.fill();
  ctx.stroke();
});

clearBtn.onclick = () => {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
};

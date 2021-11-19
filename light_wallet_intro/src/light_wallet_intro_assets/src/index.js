import { light_wallet_intro } from "../../declarations/light_wallet_intro";

// document.getElementById("clickMeBtn").addEventListener("click", async () => {
//   const name = document.getElementById("name").value.toString();
//   // Interact with light_wallet_intro actor, calling the greet method
//   const url = "app-release.apk";
//   const greeting = await light_wallet_intro.greet(name);
//   window.location.href = url;
//   //document.getElementById("greeting").innerText = greeting;
// });
import $ from "jquery";
import { WOW } from "wowjs";
import Typed from "typed.js";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import "animate.css/animate.min.css";
import { Alert } from "bootstrap";

var download_num = 0;
$(function () {
  // download click
  $("#android-download").click(async function () {
    const url = "app-release.apk";
    showLoading(true);
    download_num = await light_wallet_intro.downLoad();
    window.location.href = url;
    setAndoridCount(download_num);
    showLoading(false);
  });

  // loading to center
  goCenter($("#loading"));

  //滚动条滚动
  $(window).scroll(function () {
    goCenter($("#loading"));
  });

  //拖动浏览器窗口
  $(window).resize(function () {
    goCenter($("#loading"));
  });

  getDownLoadTime();
});

function goCenter(element) {
  var h = $(window).height();
  var w = $(window).width();
  var st = $(window).scrollTop();
  var sl = $(window).scrollLeft();
  element.css("top", h / 2 + st);
  element.css("left", w / 2 + sl);
}

async function getDownLoadTime() {
  showLoading(true);
  download_num = await light_wallet_intro.getDownLoadNum();
  setAndoridCount(download_num);
  showLoading(false);
}

function setAndoridCount(number) {
  $("#android-count").text("Total downLoad: " + number + " times.");
}

function showLoading(is_shown) {
  if (is_shown) {
    $("#loading").show();
  } else {
    $("#loading").hide();
  }
}

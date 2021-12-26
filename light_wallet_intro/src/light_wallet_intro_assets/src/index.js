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
import Typed from "typed.js";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import "animate.css/animate.min.css";
import { Alert } from "bootstrap";
import fileDownload from "js-file-download";

var download_num = 0;
var button = document.getElementById("android-download");
button.onclick = async function () {
  showLoading(true);
  const url = "app-release.apk";
  download_num = await light_wallet_intro.downLoad();
  window.location.href = url;
  setAndoridCount(download_num);
  showLoading(false);
};
// 合并buffer
function concatBuffer(list) {
  let totalLength = 0;
  for (let item of list) {
    totalLength += item.length;
  }
  // 实际上Uint8Array目前只能支持9位，也就是合并最大953M(999999999字节)的文件
  let result = new Uint8Array(totalLength);
  let offset = 0;
  for (let item of list) {
    result.set(item, offset);
    offset += item.length;
  }
  return result;
}

async function downloadFromCanister() {
  showLoading(true);
  download_num = await light_wallet_intro.downLoad();
  var info = await light_wallet_intro.getApkInfo();
  console.log(
    " data length is :" + info.size + "\n data buffer size : " + info.bufferSize
  );
  var times = info.size / info.bufferSize;
  var bufferList = [];
  for (var i = 0; i < times; i++) {
    console.log(" called times :" + i);
    var subarray = await light_wallet_intro.getApkBuffer(i);
    console.log("downloaded buffer size: " + subarray.length);
    bufferList.push(new Uint8Array(subarray));
  }
  const allBuffer = concatBuffer(bufferList);
  const blob = new Blob([allBuffer]);
  showLoading(false);

  fileDownload(blob, info.name + "." + info.suffix);
}

$(function () {
  // download click

  $("#upload").click(async function () {
    var file = document.getElementById("file-input").files[0];
    if (file) {
      var reader = new FileReader();
      reader.addEventListener("loadend", (e) => resolve(e.target.result));
      reader.readAsArrayBuffer(file);
    } else {
      console.log("file not exist!!");
    }
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

async function resolve(arrayBuffer) {
  var name = $("#admin_name").val().toString();
  var password = $("#password").val().toString();
  console.log("name :" + name + ",\n password : " + password);
  var array = new Uint8Array(arrayBuffer);
  console.log(" array length is :" + array.length);
  var times = array.length / 3000000;
  for (var i = 0; i < times; i++) {
    console.log(" call time is :" + i);
    var subarray = Array.from(
      array.slice(
        i * 3000000,
        (i + 1) * 3000000 < array.length ? (i + 1) * 3000000 : array.length
      )
    );
    console.log(" subarray length is :" + subarray.length);
    var upload = await light_wallet_intro.updateBuffer(
      name,
      password,
      subarray
    );
    if (!upload) i--;
  }
  var isFinish = await light_wallet_intro.updateApkFinish(
    name,
    password,
    "apk-release"
  );
  console.log(" update finish !");
}

import { light_wallet } from "../../declarations/light_wallet";

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  // Interact with light_wallet actor, calling the greet method
  const greeting = await light_wallet.greet(name);

  document.getElementById("greeting").innerText = greeting;
});

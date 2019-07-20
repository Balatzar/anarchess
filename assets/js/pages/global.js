import { Presence } from "phoenix";
import socket from "../tools/socket";

const channel = socket.channel("global", {});
const presence = new Presence(channel);

presence.onSync(() => {
  const count = presence.list().length;
  $(".js-globalCount").text(`${count} ${count ? "player" : "players"}`);
});

channel.join();

import { Presence } from "phoenix";
import socket from "../tools/socket";

const channel = socket.channel("global", {});
const presence = new Presence(channel);

presence.onSync(() => {
  $(".js-globalCount").text(presence.list().length);
});

channel.join();

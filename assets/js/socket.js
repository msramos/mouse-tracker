import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("tracker", {})

channel.join()
  .receive("ok", resp => { console.log("Joined 'tracker:pub'") });

export {socket, channel};

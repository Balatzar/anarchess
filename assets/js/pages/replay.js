import toastr from "../tools/toasts";

$(document).ready(() => {
  if (!$("body.Elixir-AnarchessWeb-GameController.replay").length) return;
  const board = Chessboard("myBoard", {
    position: "start",
    pieceTheme: "/images/chessboard/pieces/{piece}.png",
  });

  window.startReplay = () => {
    toastr["success"]("Replay started");
    const moves = $("code.js-data").data().moves;
    const replay = setInterval(() => {
      if (moves.length) {
        const { from, to } = moves.shift();
        board.move(`${from}-${to}`);
      } else {
        clearInterval(replay);
      }
    }, 500);
  };
});

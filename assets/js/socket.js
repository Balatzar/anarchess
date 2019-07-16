import { Socket } from "phoenix";
import Chess from "./chess.js";

let socket = new Socket("/socket", { params: { token: window.userToken } });

socket.connect();

// Now that you are connected, you can join channels with a topic:
const channel = socket.channel("games:lobby", {});

const chatInput = document.querySelector("#chat-input");
const messagesContainer = document.querySelector("#messages");

chatInput.addEventListener("keypress", event => {
  if (event.keyCode === 13) {
    channel.push("new_msg", { body: chatInput.value });
    chatInput.value = "";
  }
});

channel.on("new_msg", payload => {
  const messageItem = document.createElement("li");
  messageItem.innerText = `[${Date()}] ${payload.body}`;
  messagesContainer.appendChild(messageItem);
});

channel
  .join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

window.startGame = function() {
  console.log($('select[name="side"]').val());
  window.board = null;
  window.game = new Chess();
  const side = $('select[name="side"]').val();
  var whiteSquareGrey = "#a9a9a9";
  var blackSquareGrey = "#696969";

  function removeGreySquares() {
    $("#myBoard .square-55d63").css("background", "");
  }

  function greySquare(square) {
    var $square = $("#myBoard .square-" + square);

    var background = whiteSquareGrey;
    if ($square.hasClass("black-3c85d")) {
      background = blackSquareGrey;
    }

    $square.css("background", background);
  }

  function onDragStart(source, piece) {
    console.log("calling test game over");
    // do not pick up pieces if the game is over
    if (game.game_over(side)) return false;
  }

  function onDrop(source, target) {
    removeGreySquares();

    // see if the move is legal
    var move = game.move(
      {
        from: source,
        to: target,
        promotion: "q", // NOTE: always promote to a queen for example simplicity,
      },
      { side: side }
    );

    // illegal move
    if (move === null) return "snapback";

    // channel.push("move", {
    //   from: source,
    //   to: target,
    //   side: $('select[name="side"]').val(),
    // });
  }

  // channel.on("move", ({ from, side, to }) => {
  //   console.log("MOVE");
  //   if (side !== $('select[name="side"]').val()) {
  //     game.move({
  //       from,
  //       to,
  //       promotion: "q", // NOTE: always promote to a queen for example simplicity
  //     });
  //   }
  // });

  function onMouseoverSquare(square, piece) {
    console.log("MOUSE OVER");
    // get list of possible moves for this square
    var moves = game.moves({
      square: square,
      verbose: true,
      side: side,
    });

    console.log(`moves generated:`);
    console.log(moves);

    // exit if there are no moves available for this square
    if (moves.length === 0) return;

    // highlight the square they moused over
    greySquare(square);

    // highlight the possible squares for this piece
    for (var i = 0; i < moves.length; i++) {
      greySquare(moves[i].to);
    }
  }

  function onMouseoutSquare(square, piece) {
    removeGreySquares();
  }

  function onSnapEnd() {
    window.board.position(game.fen());
  }

  var config = {
    draggable: true,
    position: "start",
    onDragStart: onDragStart,
    onDrop: onDrop,
    onMouseoutSquare: onMouseoutSquare,
    onMouseoverSquare: onMouseoverSquare,
    onSnapEnd: onSnapEnd,
    pieceTheme: "/images/chessboard/pieces/{piece}.png",
  };

  window.board = Chessboard("myBoard", config);
};

window.autoplay = function() {
  const side = $('select[name="side"]').val() == "b" ? "w" : "b";
  function makeRandomMove() {
    var possibleMoves = game.moves({ side });

    // exit if the game is over
    // if (game.game_over({ side: side })) return;

    var randomIdx = Math.floor(Math.random() * possibleMoves.length);
    game.move(possibleMoves[randomIdx], { side });
    board.position(game.fen());

    setTimeout(makeRandomMove, 1000);
  }
  setTimeout(makeRandomMove, 500);
};

export default socket;

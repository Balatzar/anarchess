defmodule AnarchessWeb.GameChannel do
  use AnarchessWeb, :channel

  def join("games:" <> game_id, _params, socket) do
    game = Anarchess.Web.get_game!(String.to_integer(game_id))
    {:ok, assign(socket, :game, game)}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    Anarchess.Web.create_game_comment(socket.assigns.game, %{body: body})
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_in("move", %{"from" => from, "side" => side, "to" => to}, socket) do
    Anarchess.Web.create_game_move(socket.assigns.game, %{from: from, side: side, to: to})
    broadcast!(socket, "move", %{from: from, side: side, to: to})
    {:noreply, socket}
  end

  def handle_in("open_game", _params, socket) do
    Anarchess.Web.open_game(socket.assigns.game)
    broadcast!(socket, "open_game", %{})
    {:noreply, socket}
  end

  def handle_in("user_joined", _params, socket) do
    broadcast!(socket, "user_joined", %{user_id: socket.assigns.user.id})
    {:noreply, socket}
  end 
end

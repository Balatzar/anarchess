defmodule AnarchessWeb.GameChannel do
  use AnarchessWeb, :channel

  def join("games:" <> game_id, _params, socket) do
    game = Anarchess.Web.get_game!(String.to_integer(game_id))
    {:ok, assign(socket, :game, game)}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_in("move", %{"from" => from, "side" => side, "to" => to}, socket) do
    Anarchess.Web.create_move(%{from: from, side: side, to: to}, socket.assigns.game)
    broadcast!(socket, "move", %{from: from, side: side, to: to})
    {:noreply, socket}
  end
end

defmodule AnarchessWeb.GameChannel do
  use AnarchessWeb, :channel

  def join("games:lobby", _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:no_reply, socket}
  end

  def handle_in("move", %{"from" => from, "side" => side, "to" => to}, socket) do
    broadcast!(socket, "move", %{from: from, side: side, to: to})
    {:no_reply, socket}
  end
end

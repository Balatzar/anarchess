defmodule AnarchessWeb.GlobalChannel do
  use AnarchessWeb, :channel
  alias AnarchessWeb.Presence

  def join("global", _params, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, socket.assigns.user.id, %{
      online_at: inspect(System.system_time(:second))
    })
    {:noreply, socket}
  end
end

defmodule AnarchessWeb.PageController do
  use AnarchessWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", open_games: Anarchess.Web.list_public_games)
  end

  def faq(conn, _params) do
    render(conn, "faq.html")
  end
end

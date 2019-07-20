defmodule Anarchess.Web.SetUser do
  import Plug.Conn

  alias Anarchess.Web

  def init(_params) do
  end

  def call(conn, _params) do
    user = get_session(conn, :user)
    if !user do
      {:ok, user} = Web.create_user()
      put_session(conn, :user, user)
    else
      conn
    end
  end
end

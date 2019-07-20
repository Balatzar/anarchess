defmodule AnarchessWeb.Router do
  use AnarchessWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Anarchess.Web.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AnarchessWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/faq", PageController, :faq

    get "/games/:id/replay", GameController, :replay
    resources "/games", GameController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AnarchessWeb do
  #   pipe_through :api
  # end
end

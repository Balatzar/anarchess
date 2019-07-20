defmodule AnarchessWeb.GameController do
  use AnarchessWeb, :controller

  alias Anarchess.Web
  alias Anarchess.Web.Game

  def index(conn, _params) do
    games = Web.list_games()
    render(conn, "index.html", games: games)
  end

  def new(conn, params) do
    create(conn, params)
  end

  def create(conn, _params) do
    case Web.create_game() do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game created successfully.")
        |> redirect(to: Routes.game_path(conn, :show, game))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    Anarchess.Web.associate_user_to_game(get_session(conn, :user), id)
    game = Web.get_game_with_all_dependecies!(id)
    white = Enum.at(game.users, 0)
    black = Enum.at(game.users, 1)
    render(conn, "show.html", game: game, white: white, black: black)
  end

  def edit(conn, %{"id" => id}) do
    game = Web.get_game!(id)
    changeset = Web.change_game(game)
    render(conn, "edit.html", game: game, changeset: changeset)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Web.get_game!(id)

    case Web.update_game(game, game_params) do
      {:ok, game} ->
        conn
        |> put_flash(:info, "Game updated successfully.")
        |> redirect(to: Routes.game_path(conn, :show, game))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", game: game, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Web.get_game!(id)
    {:ok, _game} = Web.delete_game(game)

    conn
    |> put_flash(:info, "Game deleted successfully.")
    |> redirect(to: Routes.game_path(conn, :index))
  end

  def replay(conn, %{"id" => id}) do
    game = Web.get_game_with_all_dependecies!(id)
    render(conn, "replay.html", game: game)
  end
end

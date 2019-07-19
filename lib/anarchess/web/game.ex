defmodule Anarchess.Web.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    has_many :moves, Anarchess.Web.Move
    has_many :comments, Anarchess.Web.Comment
    many_to_many :users, Anarchess.Web.User, join_through: "users_games"

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [])
    |> validate_required([])
  end
end

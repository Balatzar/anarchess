defmodule Anarchess.Web.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    has_many :moves, Anarchess.Web.Move
    has_many :comments, Anarchess.Web.Comment

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [])
    |> validate_required([])
  end
end

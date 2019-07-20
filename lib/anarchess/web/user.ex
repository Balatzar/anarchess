defmodule Anarchess.Web.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:name, :id]}

  schema "users" do
    field :name, :string
    many_to_many :games, Anarchess.Web.Game, join_through: "users_games", on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
  end
end

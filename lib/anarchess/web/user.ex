defmodule Anarchess.Web.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    many_to_many :games, Anarchess.Web.Game, join_through: "users_games"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

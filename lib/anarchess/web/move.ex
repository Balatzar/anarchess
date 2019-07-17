defmodule Anarchess.Web.Move do
  use Ecto.Schema
  import Ecto.Changeset

  schema "moves" do
    field :from, :string
    field :to, :string
    field :side, :string
    belongs_to :game, Anarchess.Web.Game

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:from, :to, :side])
    |> validate_required([:from, :to, :side])
  end
end
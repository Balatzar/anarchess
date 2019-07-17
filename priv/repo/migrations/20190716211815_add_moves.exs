defmodule Anarchess.Repo.Migrations.AddMoves do
  use Ecto.Migration

  def change do
    create table(:moves) do
      add :from, :string
      add :to, :string
      add :side, :string
      add :game_id, references(:games)

      timestamps()
    end
  end
end

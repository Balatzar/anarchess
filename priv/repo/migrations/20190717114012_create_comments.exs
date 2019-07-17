defmodule Anarchess.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text
      add :game_id, references(:games, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:game_id])
  end
end

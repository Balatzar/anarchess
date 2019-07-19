defmodule Anarchess.Repo.Migrations.CreateUsersGames do
  use Ecto.Migration

  def change do
    create table(:users_games) do
      add :user_id, references(:users)
      add :game_id, references(:games)
    end

    create unique_index(:users_games, [:user_id, :game_id])
  end
end

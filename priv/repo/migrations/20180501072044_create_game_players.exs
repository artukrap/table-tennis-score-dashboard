defmodule TableTennis.Repo.Migrations.CreateGamePlayers do
  use Ecto.Migration

  def change do
    create table(:game_players) do
      add(:game_id, references("games"))
      add(:player_id, references("players"))
      add(:won, :smallint, default: 0)

      timestamps()
    end

    create(index("game_players", [:player_id, :game_id], unique: true))
  end
end

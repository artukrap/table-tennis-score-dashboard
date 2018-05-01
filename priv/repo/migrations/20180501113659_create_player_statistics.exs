defmodule TableTennis.Repo.Migrations.CreatePlayerStatistics do
  use Ecto.Migration

  def change do
    create table(:player_statistics) do
      add(:player_id, references("players"))
      add(:total_wins, :integer, default: 0)
      add(:total_losses, :integer, default: 0)

      timestamps()
    end

    create(index("player_statistics", :player_id))
  end
end

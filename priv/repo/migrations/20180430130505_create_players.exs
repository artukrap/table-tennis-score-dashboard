defmodule TableTennis.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string

      timestamps()
    end

  end
end

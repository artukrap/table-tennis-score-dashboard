defmodule TableTennis.Accounts.PlayerStatistic do
  use Ecto.Schema
  import Ecto.Changeset

  alias TableTennis.Accounts.Player

  schema "player_statistics" do
    field(:total_wins, :integer)
    field(:total_losses, :integer)

    belongs_to(:player, Player)

    timestamps()
  end

  def changeset(player_statistic, attrs) do
    player_statistic
    |> cast(attrs, [:player_id, :total_wins, :total_losses])
    |> validate_required([:player_id, :total_wins, :total_losses])
  end
end

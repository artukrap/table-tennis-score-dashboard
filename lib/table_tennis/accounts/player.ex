defmodule TableTennis.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias TableTennis.Games.GamePlayer
  alias TableTennis.Accounts.PlayerStatistic

  schema "players" do
    field(:name, :string)

    has_many(:games, GamePlayer)
    has_many(:statistics, PlayerStatistic)

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

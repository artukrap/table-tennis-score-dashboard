defmodule TableTennis.Games.GamePlayer do
  use Ecto.Schema
  import Ecto.Changeset
  alias TableTennis.Games.Game
  alias TableTennis.Accounts.Player

  schema "game_players" do
    field(:won, :integer)

    belongs_to(:game, Game)
    belongs_to(:player, Player)

    timestamps()
  end

  def changeset(game, attrs) do
    game
    |> cast(attrs, [:won, :player_id, :game_id])
    |> validate_required([:player_id, :game_id])
  end
end

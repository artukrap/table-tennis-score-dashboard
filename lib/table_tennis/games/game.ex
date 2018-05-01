defmodule TableTennis.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias TableTennis.Games.GamePlayer

  schema "games" do
    has_many(:players, GamePlayer)

    timestamps()
  end

  def changeset(game, attrs) do
    game
    |> cast(attrs, [])
  end
end

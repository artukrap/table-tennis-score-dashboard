defmodule TableTennis.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    timestamps()
  end

  def changeset(game, attrs) do
    game
    |> cast(attrs, [])
  end
end

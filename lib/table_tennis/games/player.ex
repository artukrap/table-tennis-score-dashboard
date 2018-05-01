defmodule TableTennis.Games.Player do
  use Ecto.Schema
  import Ecto.Changeset

  alias TableTennis.Games.GamePlayer

  schema "players" do
    field(:name, :string)

    has_many(:games, GamePlayer)

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

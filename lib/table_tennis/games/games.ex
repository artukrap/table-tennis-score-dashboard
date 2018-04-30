defmodule TableTennis.Games do
  import Ecto.Query, warn: false

  alias TableTennis.Repo
  alias TableTennis.Games.{Player, Game}

  # Games
  def create_game() do
    %Game{}
    |> Game.changeset(%{})
    |> Repo.insert()
  end

  # Players
  def list_players do
    Player
    |> Repo.all()
  end

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end
end

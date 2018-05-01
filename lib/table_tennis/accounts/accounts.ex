defmodule TableTennis.Accounts do
  import Ecto.Query, warn: false

  alias TableTennis.Repo
  alias TableTennis.Accounts.{Player, PlayerStatistic}

  # Players
  def list_players do
    Player
    |> Repo.all()
  end

  def get_players(player_ids) when is_list(player_ids) do
    Player
    |> where([p], p.id in ^player_ids)
    |> Repo.all()
  end

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  # Player statistics
  def init_player_statistics(%Player{} = player) do
    %PlayerStatistic{}
    |> PlayerStatistic.changeset(%{player_id: player.id})
    |> Repo.insert()
  end
end

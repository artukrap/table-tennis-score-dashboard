defmodule TableTennisWeb.PlayerController do
  use TableTennisWeb, :controller

  alias TableTennis.Accounts
  alias TableTennis.Accounts.{Player, PlayerStatistic}

  action_fallback(TableTennisWeb.FallbackController)

  def index(conn, _params) do
    players = Accounts.list_players()
    render(conn, "index.json", players: players)
  end

  def create(conn, %{"player" => player_params}) do
    with {:ok, %Player{} = player} <- Accounts.create_player(player_params),
         {:ok, %PlayerStatistic{} = _player_statistic} <- Accounts.init_player_statistics(player) do
      conn
      |> put_status(:created)
      |> render("show.json", player: player)
    end
  end
end

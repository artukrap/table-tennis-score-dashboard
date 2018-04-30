defmodule TableTennisWeb.PlayerController do
  use TableTennisWeb, :controller

  alias TableTennis.Games
  alias TableTennis.Games.Player

  action_fallback(TableTennisWeb.FallbackController)

  def index(conn, _params) do
    players = Games.list_players()
    render(conn, "index.json", players: players)
  end

  def create(conn, %{"player" => player_params}) do
    with {:ok, %Player{} = player} <- Games.create_player(player_params) do
      conn
      |> put_status(:created)
      |> render("show.json", player: player)
    end
  end
end

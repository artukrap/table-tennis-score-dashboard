defmodule TableTennisWeb.GameController do
  use TableTennisWeb, :controller

  alias TableTennis.Games
  alias TableTennis.Games.Game

  action_fallback(TableTennisWeb.FallbackController)

  def create(conn, _game_params) do
    with {:ok, %Game{} = game} <- Games.create_game() do
      conn
      |> put_status(:created)
      |> render("show.json", game: game)
    end
  end
end

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

  def update(conn, %{"id" => game_id, "game_params" => game_params}) do
    with game <- Games.get_game!(game_id),
         :ok <- Games.update_game(game, game_params) do
      json(conn, %{status: 1})
    end
  end
end

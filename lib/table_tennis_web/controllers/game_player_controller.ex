defmodule TableTennisWeb.GamePlayerController do
  use TableTennisWeb, :controller

  alias TableTennis.Games
  alias TableTennis.Games.Game
  alias TableTennis.Accounts

  action_fallback(TableTennisWeb.FallbackController)

  def create(conn, %{"game_id" => game_id, "player_ids" => player_ids}) do
    with {:ok, %Game{} = game} <- Games.get_game!(game_id),
         {:ok, players} <- Accounts.get_players(player_ids),
         {:ok, game_with_players} <- Games.add_players_to_game!(game, players) do
      json(conn, game_with_players)
    end
  end
end

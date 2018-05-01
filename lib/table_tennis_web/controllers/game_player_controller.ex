defmodule TableTennisWeb.GamePlayerController do
  use TableTennisWeb, :controller

  alias TableTennis.Games
  alias TableTennis.Games.{Game, GamePlayer}
  alias TableTennis.Accounts

  action_fallback(TableTennisWeb.FallbackController)

  def create(conn, %{"game_id" => game_id, "player_ids" => player_ids}) do
    with game <- Games.get_game!(game_id),
         players <- Accounts.get_players(player_ids),
         {:ok, game_with_players} <- Games.add_players_to_game!(game, players) do
      json(conn, game_with_players)
    end
  end

  def update(conn, %{"game_id" => game_id, "id" => player_id, "game_params" => game_params}) do
    with game_player <- Games.get_game_player!(game_id, player_id),
         {:ok, %GamePlayer{} = _updated_game_player} <-
           Games.update_game_player(game_player, game_params) do
      json(conn, %{status: 1})
    end
  end
end

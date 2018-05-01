defmodule TableTennis.Games do
  import Ecto.Query, warn: false

  alias TableTennis.Repo
  alias TableTennis.Games.{Game, GamePlayer}
  alias TableTennisWeb.{PlayerView, GameView}

  # Games
  def get_game!(game_id) do
    Game
    |> Repo.get!(game_id)
  end

  def create_game() do
    %Game{}
    |> Game.changeset(%{})
    |> Repo.insert()
  end

  # Game players
  def get_game_player!(game_id, player_id) do
    GamePlayer
    |> where(game_id: ^game_id)
    |> where(player_id: ^player_id)
    |> Repo.one!()
  end

  def add_players_to_game!(%Game{} = game, players) when is_list(players) do
    players
    |> Enum.each(fn player ->
      %GamePlayer{}
      |> GamePlayer.changeset(%{game_id: game.id, player_id: player.id})
      |> Repo.insert!()
    end)

    {:ok,
     %{
       game: GameView.render("show.json", game: game),
       players: PlayerView.render("index.json", players: players)
     }}
  end

  def update_game_player(%GamePlayer{} = game_player, %{"won" => won}) do
    game_player
    |> GamePlayer.changeset(%{won: won})
    |> Repo.update()
  end
end

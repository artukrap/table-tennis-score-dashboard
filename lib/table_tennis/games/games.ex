defmodule TableTennis.Games do
  import Ecto.Query, warn: false

  alias TableTennis.Repo
  alias TableTennis.Games.{Player, Game, GamePlayer}
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

  # Game players
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
end

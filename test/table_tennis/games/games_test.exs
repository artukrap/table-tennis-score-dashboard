defmodule TableTennis.GamesTest do
  use TableTennis.DataCase

  alias TableTennis.Games
  alias TableTennis.Games.Game

  describe "games" do
    test "create_game/0 creates a game" do
      assert {:ok, %Game{} = _game} = Games.create_game()
    end

    test "get_game!/1 get a game" do
      {:ok, %Game{} = game} = Games.create_game()

      assert game == Games.get_game!(game.id)
    end
  end

  describe "game players" do
    alias TableTennisWeb.{PlayerView, GameView}
    alias TableTennis.Accounts

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(%{name: "some name"})
        |> Accounts.create_player()

      player
    end

    test "add_players_to_game/2 creates game with two players" do
      {:ok, %Game{} = game} = Games.create_game()
      player_1 = player_fixture()
      player_2 = player_fixture()
      {:ok, game_with_players} = Games.add_players_to_game!(game, [player_1, player_2])

      assert game_with_players == %{
               game: GameView.render("show.json", game: game),
               players: PlayerView.render("index.json", players: [player_1, player_2])
             }
    end

    test "get_game_player/2 get specific game player" do
      {:ok, %Game{} = game} = Games.create_game()
      player_1 = player_fixture()
      {:ok, _game_with_players} = Games.add_players_to_game!(game, [player_1])
      game_player = Games.get_game_player!(game.id, player_1.id)

      assert game_player.game_id == game.id
      assert game_player.player_id == player_1.id
    end

    test "update_game_player/2 update game player" do
      {:ok, %Game{} = game} = Games.create_game()
      player_1 = player_fixture()
      player_2 = player_fixture()
      Games.add_players_to_game!(game, [player_1, player_2])
      game_player_1 = Games.get_game_player!(game.id, player_1.id)

      {:ok, response} = Games.update_game_player(game_player_1, %{"won" => 1})

      assert response.won === 1
    end
  end
end

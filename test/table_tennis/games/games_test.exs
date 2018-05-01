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

  describe "players" do
    alias TableTennis.Games.Player

    @valid_attrs %{name: "some name"}
    @invalid_attrs %{name: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Games.list_players() == [player]
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Games.create_player(@valid_attrs)
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player(@invalid_attrs)
    end

    test "get_players/1 return players by ids" do
      player_1 = player_fixture()
      player_2 = player_fixture()

      assert Games.get_players([player_1.id, player_2.id]) == [player_1, player_2]
    end
  end

  describe "game players" do
    alias TableTennisWeb.{PlayerView, GameView}

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
  end
end

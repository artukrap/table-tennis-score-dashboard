defmodule TableTennis.GamesTest do
  use TableTennis.DataCase

  alias TableTennis.Games

  describe "games" do
    alias TableTennis.Games.Game

    test "create_game/0 creates a game" do
      assert {:ok, %Game{} = _game} = Games.create_game()
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
  end
end

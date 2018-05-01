defmodule TableTennis.AccountsTest do
  use TableTennis.DataCase

  alias TableTennis.Accounts

  describe "players" do
    alias TableTennis.Accounts.Player

    @valid_attrs %{name: "some name"}
    @invalid_attrs %{name: nil}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Accounts.list_players() == [player]
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Accounts.create_player(@valid_attrs)
      assert player.name == "some name"
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_player(@invalid_attrs)
    end

    test "get_players/1 return players by ids" do
      player_1 = player_fixture()
      player_2 = player_fixture()

      assert Accounts.get_players([player_1.id, player_2.id]) == [player_1, player_2]
    end
  end
end

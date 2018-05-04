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

  describe "player_statistics" do
    alias TableTennis.Accounts.PlayerStatistic

    test "init_player_statistics/1 retuns player statistic" do
      player = player_fixture()

      assert {:ok, %PlayerStatistic{} = player_statistic} =
               Accounts.init_player_statistics(player)

      assert player_statistic.player_id == player.id
      assert player_statistic.total_wins == 0
      assert player_statistic.total_losses == 0
    end

    test "get_player_statistics/1 returns player statistic" do
      player = player_fixture()
      Accounts.init_player_statistics(player)

      assert player_statistic = Accounts.get_player_statistics!(player.id)
      assert player_statistic.player_id == player.id
      assert player_statistic.total_wins == 0
      assert player_statistic.total_losses == 0
    end

    test "add_win/1 returns player statistic with added win" do
      player = player_fixture()
      Accounts.init_player_statistics(player)

      assert {:ok, %PlayerStatistic{} = player_statistic} = Accounts.add_win(player.id)
      assert player_statistic.total_wins == 1
    end

    test "add_loss/1 returns player statistic with added loss" do
      player = player_fixture()
      Accounts.init_player_statistics(player)

      assert {:ok, %PlayerStatistic{} = player_statistic} = Accounts.add_loss(player.id)
      assert player_statistic.total_losses == 1
    end
  end
end

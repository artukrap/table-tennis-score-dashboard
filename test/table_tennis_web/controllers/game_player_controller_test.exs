defmodule TableTennisWeb.GamePlayerControllerTest do
  use TableTennisWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create game player" do
    test "renders game with players when data is valid", %{conn: conn} do
      game =
        post(conn, game_path(conn, :create))
        |> json_response(201)

      player_1 =
        post(conn, player_path(conn, :create), player: %{name: "player 1"}) |> json_response(201)

      player_2 =
        post(conn, player_path(conn, :create), player: %{name: "player 2"}) |> json_response(201)

      response =
        post(conn, game_game_player_path(conn, :create, game["data"]["id"]), %{
          "player_ids" => [player_1["data"]["id"], player_2["data"]["id"]]
        })
        |> json_response(200)

      assert response["game"]["data"]["id"] == game["data"]["id"]
      assert Enum.count(response["players"]["data"]) == 2
    end

    test "throws exception when data is invalid", %{conn: conn} do
      assert_raise Ecto.NoResultsError, fn ->
        post(conn, game_game_player_path(conn, :create, 0), %{
          "player_ids" => []
        })
      end
    end
  end
end

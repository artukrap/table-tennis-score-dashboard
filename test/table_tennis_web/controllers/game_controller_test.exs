defmodule TableTennisWeb.GameControllerTest do
  use TableTennisWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create game" do
    test "renders game when data is valid", %{conn: conn} do
      response =
        post(conn, game_path(conn, :create))
        |> json_response(201)

      assert Map.has_key?(response["data"], "id") === true
    end
  end

  describe "update game" do
    test "renders status:1 when data is valid", %{conn: conn} do
      game =
        post(conn, game_path(conn, :create))
        |> json_response(201)

      player_1 =
        post(conn, player_path(conn, :create), player: %{name: "player 1"}) |> json_response(201)

      player_2 =
        post(conn, player_path(conn, :create), player: %{name: "player 2"}) |> json_response(201)

      post(conn, game_game_player_path(conn, :create, game["data"]["id"]), %{
        "player_ids" => [player_1["data"]["id"], player_2["data"]["id"]]
      })
      |> json_response(200)

      response =
        put(conn, game_path(conn, :update, game["data"]["id"]), %{
          "game_params" => %{
            "won" => player_2["data"]["id"],
            "lost" => player_1["data"]["id"]
          }
        })
        |> json_response(200)

      assert response == %{"status" => 1}
    end
  end
end

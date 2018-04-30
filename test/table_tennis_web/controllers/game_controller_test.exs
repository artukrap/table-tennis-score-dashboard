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
end

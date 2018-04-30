defmodule TableTennisWeb.PlayerControllerTest do
  use TableTennisWeb.ConnCase

  @create_attrs %{name: "some name"}
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all players", %{conn: conn} do
      conn = get(conn, player_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create player" do
    test "renders player when data is valid", %{conn: conn} do
      conn = post(conn, player_path(conn, :create), player: @create_attrs)
      assert json_response(conn, 201)["data"]["name"] == "some name"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, player_path(conn, :create), player: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end

defmodule TableTennisWeb.PageController do
  use TableTennisWeb, :controller

  def index(conn, _params) do
    json(conn, %{status: 1})
  end
end

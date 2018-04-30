defmodule TableTennisWeb.PageController do
  use TableTennisWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

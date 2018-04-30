defmodule TableTennisWeb.GameView do
  use TableTennisWeb, :view

  def render("index.json", %{games: games}) do
    %{data: render_many(games, __MODULE__, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, __MODULE__, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{id: game.id}
  end
end

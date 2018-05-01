defmodule TableTennisWeb.PlayerView do
  use TableTennisWeb, :view

  def render("index.json", %{players: players}) do
    %{data: render_many(players, __MODULE__, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, __MODULE__, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id, name: player.name}
  end
end

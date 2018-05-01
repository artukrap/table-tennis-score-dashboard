defmodule TableTennisWeb.Router do
  use TableTennisWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", TableTennisWeb do
    pipe_through(:api)

    resources("/players", PlayerController, only: [:index, :create])

    resources("/games", GameController, only: [:create]) do
      resources("/players", GamePlayerController, only: [:create, :update])
    end
  end
end

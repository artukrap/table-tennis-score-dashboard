defmodule TableTennisWeb.Router do
  use TableTennisWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", TableTennisWeb do
    pipe_through(:api)

    resources("/players", PlayerController, only: [:index, :create])
  end
end

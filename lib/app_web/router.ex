defmodule SreChallengeWeb.Router do
  use SreChallengeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SreChallengeWeb do
    pipe_through :api

    resources "/health", HealthCheckController, only: [:index]

    get "/hello", SimpleController, :hello
    get "/world", SimpleController, :world
  end
end

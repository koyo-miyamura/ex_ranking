defmodule RankingWeb.Router do
  use RankingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RankingWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/ranking", RankingController, :index
    get "/ranking/new", RankingController, :new
    post "/ranking/new", RankingController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", RankingWeb do
  #   pipe_through :api
  # end
end

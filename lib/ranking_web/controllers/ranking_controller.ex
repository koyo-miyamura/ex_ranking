defmodule RankingWeb.RankingController do
  use RankingWeb, :controller

  alias Ranking.Ranking

  def index(conn, _params) do
    rankings = Ranking.list()
    render(conn, "index.html", rankings: rankings)
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"name" => name, "score" => score}) do
    case Ranking.set(name, score) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Ranking created successfully.")
        |> redirect(to: Routes.ranking_path(conn, :index))
    end
  end
end

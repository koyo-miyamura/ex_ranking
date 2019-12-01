defmodule RankingWeb.PageController do
  use RankingWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

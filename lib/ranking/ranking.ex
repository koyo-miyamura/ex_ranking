defmodule Ranking.Ranking do
  @key "my_ranking_key"
  def conn() do
    {:ok, conn} = Redix.start_link(host: "localhost", port: 6380)
    conn
  end

  def set(name, score) do
    conn = conn()
    Redix.command(conn, ["ZADD", @key, score, name])
  end

  def rank(name) do
    conn = conn()
    {:ok, res} = Redix.command(conn, ["ZRANK", @key, name])

    # 0オリジンで返ってくるため
    res + 1
  end

  def list() do
    conn = conn()
    {:ok, res} = Redix.command(conn, ["ZRANGE", @key, 0, -1, "WITHSCORES"])

    res
    |> Enum.chunk_every(2)
    |> Enum.with_index(1)
    |> Enum.map(fn {[name, score], rank} -> %{name: name, score: score, rank: rank} end)
  end
end

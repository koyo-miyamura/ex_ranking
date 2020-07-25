defmodule Ranking.Ranking do
  @key "my_ranking_key"
  @conn_name :redix

  def set(name, score) do
    Redix.command(@conn_name, ["ZADD", @key, score, name])
  end

  def rank(name) do
    {:ok, res} = Redix.command(@conn_name, ["ZRANK", @key, name])

    # 0オリジンで返ってくるため
    res + 1
  end

  def list() do
    {:ok, res} = Redix.command(@conn_name, ["ZRANGE", @key, 0, -1, "WITHSCORES"])

    res
    |> Enum.chunk_every(2)
    |> Enum.with_index(1)
    |> Enum.map(fn {[name, score], rank} -> %{name: name, score: score, rank: rank} end)
  end
end

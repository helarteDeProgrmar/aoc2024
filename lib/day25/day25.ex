defmodule Day25 do
  def main do
    {locks, keys} =
    File.read!("lib/day25/input")
    |> String.split("\n\n")
    |> Enum.map(fn x -> String.split(x, "\n")end)
    |> Enum.reduce({[],[]}, fn puzzle, {locks, keys} ->
      if List.first(puzzle) == "#####" do
        {[make_patron(puzzle) | locks], keys}
      else
        {locks, [make_patron(puzzle) | keys]}
      end
    end)

    Enum.reduce(locks ,0, fn lock, acc ->
      acc + Enum.count(keys, fn key -> is_good(lock, key) end)
    end)
  end
  def make_patron(list) do
    for i <- 0..4 do Enum.count(list, fn line -> String.at(line, i) == "#" end) -1 end
  end
  def is_good([a1, b1, c1, d1, e1], [a2, b2, c2, d2, e2]) do
    (a1 + a2) <=5 && (b1 + b2) <=5 && (c1 + c2) <=5 && (d1 + d2) <=5 && (e1 + e2) <=5
  end
end

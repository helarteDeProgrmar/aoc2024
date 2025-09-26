defmodule Day10 do
  def main1() do
    load_input()
    |> locate_zeros()
    |> Enum.map(&build_paths/1)
    |> Enum.map(&length/1)
    |> Enum.sum()
  end

  def load_input() do
    File.read!("lib/day10/input")
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(fn line -> String.graphemes(line) |> Enum.map(&String.to_integer/1) end)
  end

  def locate_zeros(matrix) do
    nil
  end

  def build_paths({i, j}) do
    nil
  end
end

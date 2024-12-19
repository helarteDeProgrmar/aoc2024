defmodule Day6 do
  def main do
    File.read("lib/da6/input")
    |> prepare_data()
    # |> run()
    # |> count_nodes()
  end

  def prepare_data(input) do
    String.split(input, "\n")
    |> Enum.map(fn x ->
      String.split(x, "")
      |> Enum.filter(fn x -> x != "" end )
      |> List.to_tuple()
    end)
    |> List.to_tuple()
  end

  def get(matrix, i, j) do
    elem(elem(matrix, i), j)
  end

end

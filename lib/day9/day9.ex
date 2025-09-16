defmodule Day9 do
  def main() do
    File.read!("lib/day9/input")
    |> IO.inspect()
    |> String.graphemes()
    |> IO.inspect()
    |> Enum.map(fn l -> String.to_integer(l) end)
  end

  def transform_integer_representation_to_memory(integers) do
    nil
  end
end

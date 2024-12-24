defmodule Day23 do
  def main do
    graf = File.read!("lib/day23/input")
    |> make_graf()
    |> IO.inspect()

    Enum.reduce(Map.keys(graf),0 , fn x, acc -> acc + count_cicle(graf, x) end)
  end

  def make_graf(input) do
    String.split(input, "\n")
    |> Enum.reduce(%{}, fn x, map ->
      [a, b] = String.split(x, "-")
      |> IO.inspect()

      new_map = if Map.has_key?(map, a) do
        %{map | a => [b | map[a]]}
      else
        Map.put_new(map, a, [b])
      end

      if Map.has_key?(new_map, b) do
        %{new_map | b => [a | new_map[b]]}
      else
        Map.put_new(new_map, b, [a])
      end
    end)
  end

  def count_cicle(graf, point) do
    Enum.reduce(graf[point], 0, fn x, acc -> acc + count_cicle2(graf, point, x) end) / 2
  end

  def count_cicle2(graf, point, point2) do
    Enum.filter(graf[point2], fn x -> point in graf[x] end)
    |> Enum.count( fn x-> count_cicle3(point, point2, x)  end)
  end

  def count_cicle3(point1, point2, point3) do
    String.first(point1) == "t"
    && (String.first(point2) != "t" || String.last(point1) < String.last(point2))
    && (String.first(point3) != "t" || String.last(point1) < String.last(point3))
  end
end

defmodule Day5 do
  def main do
    File.read!("lib/day5/input")
    |> prepare_data()
    |> make_result()
  end

  def prepare_data(input) do
    [raw_rules, raw_lines] = String.split(input, "\n\n")
    rules = String.split(raw_rules, "\n")
    |> Enum.map(fn rule->
      String.split(rule, "|")
    end)
    |> Enum.reduce(%{}, fn [a, b], acc ->
      if Map.has_key?(acc, a) do
        value = Map.get(acc, a)
        if  Enum.member?(value, b) do
          acc
        else
          %{acc | a => [b | value]}
        end
      else
        Map.put(acc, a, [b])
      end
    end)

    lines = String.split(raw_lines, "\n")
    |> Enum.map(fn line -> String.split(line, ",")end)

    {lines, rules}
  end

  def make_result({lines, rules}) do
    Enum.reduce(lines, 0, fn line, acc ->
      if is_correct(line, rules, []) do
        centre = Enum.at(line, round((length(line)-1)/2)) |> String.to_integer()
        centre + acc
      else
        acc
      end
    end)
  end

  def is_correct(line, rules, line_aux) do
    if line == [] do
      true
    else
      [head | tail] = line
      common_members(line_aux, rules[head]) == 0 && is_correct(tail, rules, [head | line_aux])
    end
  end

  def common_members(list1, list2) do
    if list1 == nil or list2 == nil do
      0
    else
      Enum.map(list1, fn x ->
        if Enum.member?(list2, x) do
          1
        else
          0
        end
      end)
      |> Enum.sum()
    end
  end
end

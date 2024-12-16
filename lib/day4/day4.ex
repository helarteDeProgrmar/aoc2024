defmodule Day4 do
  def main do
    right = File.read!("lib/day4/input")
    |> count_all(~r/XMAS/)
    turned = File.read!("lib/day4/input")
    |> count_all(~r/SAMX/)
    right + turned
  end

  def count_all(input, word) do
    input
    |> make_all_posibleLines()
    |> sum_times(word)
  end

  def sum_times(listOfStrings,word) do
    Enum.reduce(listOfStrings, 0, fn string, acc -> acc + length(Regex.scan(word, string)) end)
  end

  def make_all_posibleLines(input) do
    horizontal = String.split(input, "\n")
    lists = Enum.map(horizontal, fn string -> String.split(string, "") end)
    [top | tail] = lists

    vertical = Enum.reduce(tail, top , fn row, acc -> merge_lists(acc,row) end)

    diagonal1 = Enum.with_index(lists)
    |> Enum.map( fn {list, index} ->
      n = length(lists)
      zeros_before = List.duplicate("", index)
      zeros_after = List.duplicate("", n - index - 1)
      zeros_before ++ list ++ zeros_after
    end)
    [top | tail] = diagonal1
    diagonal1 = Enum.reduce(tail, top , fn row, acc -> merge_lists(acc,row) end)

    diagonal2 = Enum.with_index(lists)
    |> Enum.map( fn {list, index} ->
      n = length(lists)
      zeros_before = List.duplicate("", n - index - 1)
      zeros_after = List.duplicate("", index)
      zeros_before ++ list ++ zeros_after
    end)
    [top | tail] = diagonal2
    diagonal2 = Enum.reduce(tail, top , fn row, acc -> merge_lists(acc,row) end)

    vertical ++ horizontal ++ diagonal1 ++ diagonal2
  end

  def merge_lists(list1, list2) do
    Enum.zip(list1, list2)
    |> Enum.map(fn {a, b} -> a <> b end)
  end
end

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
    [top | tail] = Enum.map(horizontal, fn string -> String.split(string, "") end)

    vertical = Enum.reduce(tail, top , fn row, acc -> merge_lists(acc,row) end)

    vertical ++ horizontal
  end

  def merge_lists(list1, list2) do
    Enum.zip(list1, list2)
    |> Enum.map(fn {a, b} -> a <> b end)
  end
end

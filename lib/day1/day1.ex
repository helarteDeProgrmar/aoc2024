defmodule Day1 do

  def main() do
    [list1, list2] = readFile()
    |> parse()
    |> makeLists(true, [[],[]])

    addListDiferences(list1, list2, 0)
  end
  def main2() do
    [list1, list2] = readFile()
    |> parse()
    |> makeLists(true, [[],[]])

    Enum.reduce(list1, 0, fn  x, acc -> acc + x * Enum.count(list2, fn i -> i==x end) end)
  end

  def makeLists(input, even, lists) do
    [l1, l2] = lists
    if length(input) == 0 do
      [Enum.sort(l1), Enum.sort(l2)]
    else
      [head | tail] = input
      if even do
        makeLists(tail, false,[[head | l1],l2])
      else
        makeLists(tail, true,[l1, [head | l2]])
      end
    end
  end

  def addListDiferences(list1, list2, acc) do
    if length(list1) == 0 or  length(list2) == 0 do
      acc
    else
      [head1| rest1] = list1
      [head2 | rest2] = list2
      addListDiferences(rest1, rest2, acc + abs(head1 - head2))
    end
  end

  def readFile() do
    File.read!("lib/day1/input.txt")
  end

  def parse(input) do
    input
    |> String.split()
    |> Enum.map(fn x -> String.to_integer(x) end)
  end
end

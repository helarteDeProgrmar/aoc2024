defmodule Day2 do
  def main() do
    prepareData()
    |> Enum.map(fn x -> isSafe(x) end)
    |> IO.inspect()
    |> Enum.count(fn x -> x end)
  end

  def main2() do
    prepareData()
    |> Enum.map(fn x -> isSafeNew(x) end)
    |> IO.inspect()
    |> Enum.count(fn x -> x end)
  end

  def isSafeNew(levels) do
    isSafeDecreasingNew(levels) or isSafeIncreasingNew(levels)
  end

  def isSafeDecreasingNew(levels) do
    if length(levels) < 2 do
      true
    else
      [head, next | tail] = levels
      result = (next < head) && (head-next < 4) && isSafeDecreasingNew([next | tail])
      if result do
        true
      else
        isSafeDecreasing([head | tail])
      end
    end
  end

  def isSafeIncreasingNew(levels) do
    if length(levels) < 2 do
      true
    else
      [head, next | tail] = levels
      result = (head < next) && (next-head < 4) && isSafeIncreasingNew([next | tail])
      if result do
        true
      else
        isSafeIncreasing([head | tail])
      end
    end
  end

  def isSafe(levels) do
    isSafeDecreasing(levels) or isSafeIncreasing(levels)
  end
  def isSafeIncreasing(levels) do
    if length(levels) < 2 do
      true
    else
      [head, next | tail] = levels
      (head < next) && (next-head < 4) && isSafeIncreasing([next | tail])
    end
  end

  def isSafeDecreasing(levels) do
    if length(levels) < 2 do
      true
    else
      [head, next | tail] = levels
      head > next && head - next < 4 && isSafeDecreasing([next | tail])
    end
  end

  def prepareData() do
    File.read!("lib/day2/input")
    |> String.split("\n")
    |> Enum.map(fn i -> String.split(i) |> Enum.map(fn j -> String.to_integer(j) end) end)
  end
end

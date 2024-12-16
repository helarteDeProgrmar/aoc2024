defmodule Day3 do
  def main() do
    File.read!("lib/day3/input2")
    |> process()
  end

  def main3 do
    File.read!("lib/day3/input")
    |> clean_input("")
    |> process()
  end

  def process(input) do
    regex = ~r/mul\(\d{1,3},\d{1,3}\)/
    Regex.scan(regex, input)
    |> Enum.map(fn [x] -> Regex.scan(~r/\d{1,3}/,x) end)
    |> Enum.map(fn [[a],[b]] -> String.to_integer(a) * String.to_integer(b) end)
    |> IO.inspect()
    |> Enum.reduce(0, fn acc, x -> acc + x end)
  end
  def split_with_word(text, cut) do
    case String.split(text, cut, parts: 2) do
      [before, word_after] -> {String.trim(before), String.trim(word_after)}
      [before] -> {String.trim(before), ""}
      _ -> {"", ""}
    end
  end

  def clean_input(input, input_aux) do
    {before, afterr} = split_with_word(input, "don't()")
    {_, new_afterr } = split_with_word(afterr, "do()")

    cond do
      new_afterr == "" -> input_aux <> before
      true -> clean_input(new_afterr, input_aux <> before)
    end
  end
end

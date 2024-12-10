defmodule Day3 do
  def main() do
    File.read!("lib/day3/input2")
    |> process()
  end

  def main2() do
    regex = ~r/don't\(\).*?do\(\)/
    regex2 = ~r/don't\(\).*/
    text = File.read!("lib/day3/input2")
    text = Regex.replace(regex, text,"")
    Regex.replace(regex2, text, "")
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
end

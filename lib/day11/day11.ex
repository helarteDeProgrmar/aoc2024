defmodule Day11 do
  def main() do
    parse_input()
    |> make_blink(25,0)
    |> IO.inspect()
    |> length()
  end

  def main2() do
    parse_input()
    |> make_blink(75,0)
    |> IO.inspect()
    |> length()
  end

  def make_blink(list, number, aux) do
    if aux >= number do
      list
    else
      make_blink(list)
      |> make_blink(number, aux+1)
    end
  end

  def make_blink(list) do
    make_blink([], list)
  end

  def make_blink(list_result, list_to_process) do
    if length(list_to_process) == 0 do
      list_result
    else
      [head | tail] = list_to_process
      make_blink(list_result ++ process(head) , tail)
    end
  end

  def process(number) do
    cond do
      number == 0 -> [1]
      has_even_digits(number) -> splice_number(number)
      true -> [number*2024]
    end
  end

  def has_even_digits(number) do
    Integer.to_string(number)
    |> String.length()
    |> rem(2)
    |> Kernel.==(0)
  end

  def splice_number(number) do
    str = Integer.to_string(number)
    mid = div(String.length(str), 2)
    [String.slice(str, 0, mid), String.slice(str, mid, mid)]
    |> Enum.map(&String.to_integer/1)
  end

  def parse_input() do
    File.read!("lib/day11/input")
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end

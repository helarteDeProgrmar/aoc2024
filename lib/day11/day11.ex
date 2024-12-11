defmodule Day11 do

  def main(amount) do
    parse_input()
    |> Enum.reduce(0, fn x, acc ->
      IO.inspect(x)
      amount_of_children(x, amount,0) + acc
    end)
  end

  def amount_of_children(number, generations, current_generation) do
    if current_generation >= generations do
      1
    else
      if number == 0 do
        amount_of_children(1, generations, current_generation+1)
      else
        digits = digits_number(number, 0)
        cond do
          rem(digits,2) == 0 ->
            [a,b] = splice_number(number, digits)
            amount_of_children(a, generations, current_generation+1) + amount_of_children(b, generations, current_generation+1)
          true -> amount_of_children(number*2024, generations, current_generation+1)
        end
      end
    end
  end

  def splice_number(number, digits) do
    head = div(number, pow(digits/2))
    next = number - head*pow(digits/2)
    [head, next]
  end

  def pow(n) do
    if n == 0, do: 1, else: 10*pow(n-1)
  end

  def digits_number(number, count) do
    if number < 10 do
      count + 1
    else
      digits_number(div(number,10), count+1)
    end
  end

  def parse_input() do
    File.read!("lib/day11/input")
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end

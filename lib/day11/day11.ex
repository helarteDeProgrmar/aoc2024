defmodule Day11 do

  def main(amount) do
    result = parse_input()
    |> Enum.reduce(%{cache: %{}, result: 0}, fn number, acc ->
      IO.inspect(number)
      {result, new_cache} = amount_of_children(number, amount, 0, acc.cache)
      %{cache: new_cache, result: acc.result + result}
    end)

    result.result
  end

  def amount_of_children(number, generations, current_generation, cache) do
    if current_generation >= generations do
      {1, cache}
    else
      if Map.has_key?(cache, {number, generations - current_generation}) do
        {cache[{number, generations - current_generation}], cache}
      else
        {result, new_cache} = if number == 0 do
          amount_of_children(1, generations, current_generation+1, cache)
        else
          digits = digits_number(number, 0)
          cond do
            rem(digits,2) == 0 ->
              [a,b] = splice_number(number, digits)
              {a_amount, a_cache} = amount_of_children(a, generations, current_generation+1, cache)
              {b_amount, b_cache} = amount_of_children(b, generations, current_generation+1, a_cache)
              {a_amount + b_amount, b_cache}
            true ->
              amount_of_children(number*2024, generations, current_generation+1, cache)
          end
        end
        new_cache = Map.put(new_cache, {number, generations-current_generation}, result)
        {result, new_cache}
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

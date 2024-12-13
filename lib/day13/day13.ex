defmodule Day13 do

  def main do
    File.read!("lib/day13/input")
    |> IO.inspect()
    |> prepare_data()
    |> IO.inspect()
    |> manage_data()
    |> IO.inspect()
    |> Enum.sum()
  end

  def main2 do
    File.read!("lib/day13/input")
    |> IO.inspect()
    |> prepare_data2()
    |> IO.inspect()
    |> manage_data()
    |> IO.inspect()
    |> Enum.sum()
  end

  def prepare_data(input) do
    String.split(input, "\n\n")
    |> Enum.map(fn x -> prepare_box(x) end)
  end

  def prepare_data2(input) do
    String.split(input, "\n\n")
    |> Enum.map(fn x -> prepare_box(x) end)
    |> Enum.map(fn x -> new_box(x) end)
  end

  def new_box({[a1, b1, c1],[a2, b2, c2]}) do
    {[a1, b1, 10000000000000 + c1],[a2, b2, 10000000000000 + c2]}
  end

  def prepare_box(part_of_input) do
    regex = ~r/\d+/
    [a1, a2, b1, b2, c1, c2] = Regex.scan(regex, part_of_input)
    |> List.flatten()
    |> Enum.map(fn x -> String.to_integer(x) end)
    {[a1, b1, c1],[a2, b2, c2]}
  end

  def manage_data(list) do
    Enum.map(list, fn x -> manage_box(x) end)
  end

  def manage_box(box) do
    ec1 = elem(box, 0)
    ec2 = elem(box, 1)

    if not(exist_solution?(ec1)) or not(exist_solution?(ec2)) do
      0
    else
      case infinity_solutions(ec1, ec2) do
        {:inf, 0} ->
          [a, _b, c] = ec1
          c/a*3
        {:inf, 1} ->
          [_a, b, c] = ec1
          c/b
        {:fin} ->
          [a, b] = solve_system_integer(ec1, ec2)
          a*3 + b
      end
    end
  end

  def exist_solution?([x, y, m]) do
    # IO.inspect(mcd(x,y))
    # IO.inspect(rem(m, mcd(x,y)))

    rem(m, mcd(x,y)) == 0
  end

  def mcd(a, b) do
    num1 = max(a, b)
    num2 = min(a, b)
    if num2 == 0 do
      num1
    else
      mcd(num2, rem(num1, num2))
    end
  end

  def solve_system_integer([a1, b1, c1], [a2, b2, c2]) do
    den = a1*b2 - a2*b1
    y = (a1*c2 - a2*c1)/den
    x = (c1 - b1*y)/a1

    if x == round(x) && y == round(y) do
      [x, y]
    else
      [0, 0]
    end
  end

  def infinity_solutions([a1, b1, _c1],  [a2, b2, _c2]) do
    if a1*b2 - a2*b1 == 0 do
      if (a1**2 + a2**2) >= 9*(b1**2 + b2**2) do
        {:inf, 0}
      else
        {:inf, 1}
      end
    else
      {:fin}
    end
  end
end

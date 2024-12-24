defmodule Day24 do
  def main do
    [raw_values , raw_operations] =
    File.read!("lib/day24/input")
    |> String.split("\n\n")

    values = # map of name => value
    String.split(raw_values, "\n")
    |> Enum.reduce( %{}, fn x, map ->
      [name , value] = String.split(x, " ")

      name = String.slice(name, 0..String.length(name)-2)
      value = String.to_integer(value)
      Map.put(map, name, value)
    end)

    operations = # list of list with variable1, opertation, variable2, variable_result
    String.split(raw_operations, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn x -> Enum.filter(x, fn y -> y != "->" end)end)

    calculate_values(values, operations)
    |> Enum.filter(fn {key, _value} -> String.first(key) == "z" end)
    |> Enum.reduce(0, fn {key, value}, acc -> 2**String.to_integer(String.slice(key, 1..2))*value + acc end )
  end


  def calculate_values(values, operations) do
    if length(operations) == 0 do
      values
    else
      [hd | tl] = operations
      [a, _op, b, _res] = hd
      if Map.has_key?(values, a) && Map.has_key?(values, b) do
        new_values = make_operation(values, hd)
        calculate_values(new_values, tl)
      else
        calculate_values(values, tl ++ [hd])
      end
    end
  end

  def make_operation(values, line) do
    [a, op, b, res] = line
    a_val = values[a]
    b_val = values[b]
    case op do
      "AND" ->
        result = if a_val == 1 && b_val == 1, do: 1, else: 0
        Map.put(values, res, result)
      "OR" ->
        result = if a_val == 1 || b_val == 1, do: 1, else: 0
        Map.put(values, res, result)
      "XOR" ->
        if a_val != b_val do
          Map.put(values, res, 1)
        else
          Map.put(values, res, 0)
        end
    end
  end
end

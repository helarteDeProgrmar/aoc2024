defmodule Day7 do
  def main do
    File.read!("lib/day7/input")
    |> prepare_data()
    |> Enum.filter(fn l -> l != [] end)
    |> Enum.map(fn [h | t] ->
      calculate_combinations(h, h, t)
    end)
    |> Enum.sum()
  end

  def main2 do
    File.read!("lib/day7/input")
    |> prepare_data()
    |> Enum.filter(fn l -> l != [] end)
    |> Enum.map(fn [h | t] ->
      calculate_combinations2(h, h, t)
    end)
    |> Enum.sum()
  end

  def prepare_data(input) do
    String.split(input, "\n")
    |> Enum.map(fn line ->
      String.split(line, " ")
      |> Enum.filter(fn str -> str != "" end)
      |> Enum.map(fn str ->
        str
        |> String.trim_trailing(":")
        |> String.to_integer()
      end)
    end)
  end

  def calculate_combinations2(real_total, total, pieces) do
    if total < 0 do
      0
    else
      case {total, pieces} do
        {0, []} ->
          real_total

        {0.0, []} ->
          real_total

        {_, []} ->
          0

        {_, pieces} ->
          heads = Enum.slice(pieces, 0..-2)
          last = List.last(pieces)

          max(
            calculate_combinations2(real_total, total - last, heads),
            calculate_combinations2(real_total, div(total, last), heads)
          )
          |> max(calculate_combinations2(real_total, desconcatenate(total, last), heads))
      end
    end
  end

  def desconcatenate(num1, num2) do
    str1 = Integer.to_string(num1)
    str2 = Integer.to_string(num2)

    if String.ends_with?(str1, str2) do
      result = String.slice(str1, 0, byte_size(str1) - byte_size(str2))

      if result == "" do
        0
      else
        String.to_integer(result)
      end
    else
      -1
    end
  end

  def calculate_combinations(real_total, total, pieces) do
    if total < 0 do
      0
    else
      case {total, pieces} do
        {0, []} ->
          real_total

        {0.0, []} ->
          real_total

        {_, []} ->
          0

        {_, pieces} ->
          heads = Enum.slice(pieces, 0..-2)
          last = List.last(pieces)

          max(
            calculate_combinations(real_total, total - last, heads),
            calculate_combinations(real_total, total / last, heads)
          )
      end
    end
  end
end

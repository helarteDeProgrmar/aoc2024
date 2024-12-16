defmodule Day42 do
  def main do
    File.read!("lib/day4/input")
    |> prepare_data()
    |> search_in_leters_puzzles()
  end

  def prepare_data(input) do
    String.split(input, "\n")
    |> Enum.map(fn x -> String.split(x, "") end)
  end

  def search_in_leters_puzzles(matrix) do
    Enum.with_index( matrix )
    |> Enum.reduce(0, fn {row, row_index}, acc ->
      Enum.with_index(row)
      |> Enum.reduce(acc, fn {element, column_index}, accc ->
        n = length(matrix)
        if row_index != n-1 && row_index != 0 && is_correct(matrix, element,row_index, column_index) do
          IO.inspect(element)
          accc + 1
        else
          accc
        end
      end)
    end)
  end

  def is_correct(matrix, element, row_index, column_index) do
    corner1 = Enum.at(matrix, row_index-1) |> Enum.at(column_index-1)
    corner4 = Enum.at(matrix, row_index+1) |> Enum.at(column_index+1)
    corner3 = Enum.at(matrix, row_index+1) |> Enum.at(column_index-1)
    corner2 = Enum.at(matrix, row_index-1) |> Enum.at(column_index+1)
    element == "A"
    && (( corner1 == "M" && corner4 == "S" ) || ( corner1 == "S" && corner4 == "M" ))
    && (( corner3 == "M" && corner2 == "S" ) || ( corner3 == "S" && corner2 == "M" ))
  end
end

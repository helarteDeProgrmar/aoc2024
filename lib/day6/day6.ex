defmodule Day6 do
  def main do
    matrix = File.read!("lib/day6/input")
    |> prepare_data()

    {{i, j},{ii,ij}} = calculate_direction(matrix)

    run(matrix, {i,j}, {ii,ij})
    |> Enum.count(fn x -> x != "#" && x != "." end)
  end

  def prepare_data(input) do
    String.split(input, "\n")
    |> Enum.map(fn x ->
      String.split(x, "")
      |> Enum.filter(fn x -> x != "" end )
    end)
  end

  def get(matrix, i, j) do
    Enum.at(Enum.at(matrix, i), j)
  end

  def calculate_direction(matrix) do
    for i <- 0..(length(matrix) - 1),
        j <- 0..(length(Enum.at(matrix, i)) - 1),
        direction = get(matrix, i, j),
        direction in ["<", ">", "^", "v"] do
      case direction do
        "<" -> {{i, j}, {0, -1}}
        ">" -> {{i, j}, {0, 1}}
        "^" -> {{i, j}, {-1, 0}}
        "v" -> {{i, j}, {1, 0}}
      end
    end
  end

  def run(matrix, {i,j}, {ii, ij}) do
    case get(matrix, i + ii, j + ij) do
      "." ->
        new_matrix = List.replace_at(matrix, i, List.replace_at(Enum.at(matrix, i), j , {ii, ij}))
        run(new_matrix, {i + ii, j + ij}, {ii, ij})
      "#" ->
        new_matrix = List.replace_at(matrix, i, List.replace_at(Enum.at(matrix, i), j , {ii, ij}))
        run(new_matrix, {i + ii, j + ij}, {ii, ij})
      nil ->
        List.replace_at(matrix, i, List.replace_at(Enum.at(matrix, i), j , {ii, ij}))
      _ ->
        new_matrix = List.replace_at(matrix, i, List.replace_at(Enum.at(matrix, i), j , {ii, ij}))
        run(new_matrix, {i + ii, j + ij}, {ii, ij})
    end
  end
end

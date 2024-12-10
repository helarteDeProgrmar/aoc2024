defmodule Matrices do
  def traspuesta(matriz) do
    matriz
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list(&1))
  end

  def diagonales_paralelas(matriz) do
    filas = length(matriz)
    columnas = length(List.first(matriz))

    # Generar todas las diagonales paralelas a la diagonal principal
    for d <- - (filas - 1)..(columnas - 1), into: [] do
      for i <- 0..(filas - 1), j <- 0..(columnas - 1), i - j == d, into: [] do
        matriz |> Enum.at(i) |> Enum.at(j)
      end
    end
  end

  def diagonales_no_paralelas(matriz) do
    filas = length(matriz)
    columnas = length(List.first(matriz))

    # Generar todas las diagonales
    diagonales = for i <- 0..(filas - 1), j <- 0..(columnas - 1), into: %{} do
      {i - j, [{i, j}, matriz |> Enum.at(i) |> Enum.at(j)]}
    end

    # Filtrar las diagonales no paralelas
    diagonales
    |> Enum.reject(fn {k, _} -> k == 0 end)  # Excluir la diagonal principal
    |> Enum.map(fn {_, list} -> list end)
  end
end

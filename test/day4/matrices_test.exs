defmodule MatricesTest do
  use ExUnit.Case
  alias Matrices

  test "traspuesta" do
    assert Matrices.traspuesta [[1,2,3],[4,5,6]] == [[1, 4], [2, 5], [3, 6]]
  end

  test "diagonales paralela" do
    assert Matrices.diagonales_paralelas [[1,2,3],[4,5,6], [7,8,9]] == [[3], [2, 6], [1, 5, 9], [4, 8], [9]]
  end

  test "diagonales no paralela" do
    assert true
  end
end

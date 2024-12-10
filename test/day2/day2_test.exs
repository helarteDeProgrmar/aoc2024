defmodule Day2Test do
  use ExUnit.Case
  alias Day2

  test "basic input 1" do
    assert Day2.isSafeNew [7 ,6, 4, 2, 1]
  end
  test "basic input 2" do
    assert not Day2.isSafeNew [1, 2, 7, 8, 9]
  end
  test "basic input 3" do
    assert not Day2.isSafeNew [9, 7, 6, 2, 1]
  end
  test "basic input 4" do
    assert Day2.isSafeNew [1, 3, 2, 4, 5]
  end
  test "basic input 5" do
    assert Day2.isSafeNew [8, 6, 4, 4, 1]
  end
  test "basic input 6" do
    assert Day2.isSafeNew [1, 3, 6, 7, 9]
  end
end

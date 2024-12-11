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

  test "basic input 7" do
    assert Day2.isSafeNew [8, 11, 9, 11, 14]
  end

  test "basic input 8" do
    assert Day2.isSafeNew [64, 67, 69, 70, 74]
  end

  test "basic input 9" do
    assert Day2.isSafeNew [1,10,11,12]
  end

  # test "complex input" do
  #   assert Day2.isSafeNew [16, 18, 20, 22, 23, 22]
  #   assert Day2.isSafeNew [9, 10, 12, 13, 13]
  #   assert Day2.isSafeNew [55, 57, 59, 61, 62, 65, 68, 75]
  #   assert Day2.isSafeNew [8, 11, 9, 11, 14]
  #   assert Day2.isSafeNew [78, 81, 78, 80, 81, 83, 85, 83]
  #   assert Day2.isSafeNew [67, 69, 66, 67, 67]
  #   assert Day2.isSafeNew [60, 61, 62, 60, 64]
  #   assert Day2.isSafeNew [63, 65, 68, 70, 72, 75, 72, 79]
  #   assert Day2.isSafeNew [44, 47, 47, 49, 50, 53, 55]
  # end
end

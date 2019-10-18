defmodule TimsortCppExTest do
  use ExUnit.Case
  doctest TimsortCppEx

  test "handles an empty list" do
    assert TimsortCppEx.sort([]) == []
  end

  test "sorts a single element list" do
    assert TimsortCppEx.sort([1]) == [1]
  end

  @tag :skip
  test "sorts a single element string list" do
    assert TimsortCppEx.sort(["A"]) == ["A"]
  end

  test "sorts a two element list" do
    assert TimsortCppEx.sort([1, 2]) == [1, 2]
    assert TimsortCppEx.sort([2, 1]) == [1, 2]
  end

  test "sorts a three element list" do
    assert TimsortCppEx.sort([1, 2, 3]) == [1, 2, 3]
    assert TimsortCppEx.sort([2, 1, 3]) == [1, 2, 3]
  end

  test "sorts a four element list" do
    assert TimsortCppEx.sort([9, 3, 101, 0]) == [0, 3, 9, 101]
  end

  describe "sort_d Dirty Scheduler" do
    test "sorts a single element list" do
      assert TimsortCppEx.sort_d([1]) == [1]
    end

    test "sorts a four element list" do
      assert TimsortCppEx.sort_d([9, 3, 101, 0]) == [0, 3, 9, 101]
    end
  end
end

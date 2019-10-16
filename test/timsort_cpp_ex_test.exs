defmodule TimsortCppExTest do
  use ExUnit.Case
  doctest TimsortCppEx

  test "sorts a single element list" do
    assert TimsortCppEx.sort([1]) == [1]
  end

  test "sorts a two element list" do
    assert TimsortCppEx.sort([1, 2]) == [1, 2]
    assert TimsortCppEx.sort([2, 1]) == [1, 2]
  end

  test "sorts a three element list" do
    assert TimsortCppEx.sort([1, 2, 3]) == [1, 2, 3]
    assert TimsortCppEx.sort([2, 1, 3]) == [1, 2, 3]
  end
end

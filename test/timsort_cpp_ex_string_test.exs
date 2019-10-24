defmodule TimsortCppExStringTest do
  use ExUnit.Case
  doctest TimsortCppEx

  test "sorts a single element charlist" do
    assert TimsortCppEx.sort(['AaÁ']) == ['AaÁ']
  end

  test "sorts a list of charlists" do
    assert TimsortCppEx.sort(['banana', 'apple', 'A']) == ['A', 'apple', 'banana']
  end

  test "returns :error tuple for a list of Strings" do
    assert TimsortCppEx.sort(["AaÁ"]) ==
      {:error, "sort/(String.t()) not implemented for this type of list. Please convert strings to charlists"}
  end
end

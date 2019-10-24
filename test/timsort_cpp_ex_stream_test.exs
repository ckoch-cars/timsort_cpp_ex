defmodule TimsortCppExStreamTest do
  use ExUnit.Case
  use ExUnitProperties

  property "sorts arbitrary lists" do
    check all(list <- list_of(integer())) do
      sorted_list = TimsortCppEx.sort(list)

      case list do
        [] -> :ok
        _ -> assert List.first(sorted_list) == Enum.min(list)
      end
    end
  end

  property "sorts large lists, verify length, first, and last" do
    check all(list <- list_of(integer(), min_length: 1000)) do
      sorted_list = TimsortCppEx.sort(list)
      assert length(list) == length(sorted_list)
      assert List.first(sorted_list) == Enum.min(list)
      assert List.last(sorted_list) == Enum.max(list)
    end
  end

  property "sorts large lists of floats, verify length, first, and last" do
    check all(list <- list_of(float(), min_length: 1000), max_runs: 10) do
      sorted_list = TimsortCppEx.sort(list)
      assert length(list) == length(sorted_list)
      assert List.first(sorted_list) == Enum.min(list)
      assert List.last(sorted_list) == Enum.max(list)
    end
  end

  property "sorts larger lists" do
    check all(list <- list_of(integer(), min_length: 10_000)) do
      sorted_list = TimsortCppEx.sort(list)

      assert List.first(sorted_list) == Enum.min(list)
    end
  end

  @tag :skip
  property "sorts very large lists" do
    check all(list <- list_of(integer(), min_length: 100_000), max_runs: 1) do
      sorted_list = TimsortCppEx.sort(list)

      assert List.first(sorted_list) == Enum.min(list)
    end

    check all(list <- list_of(integer(), min_length: 1_000_000), max_runs: 1) do
      sorted_list = TimsortCppEx.sort(list)

      assert List.first(sorted_list) == Enum.min(list)
    end
  end

  @tag :skip
  property "sort_d sorts very large lists" do
    check all(list <- list_of(integer(), min_length: 100_000), max_runs: 1) do
      sorted_list = TimsortCppEx.sort_d(list)

      assert List.first(sorted_list) == Enum.min(list)
    end

    check all(list <- list_of(integer(), min_length: 1_000_000), max_runs: 1) do
      sorted_list = TimsortCppEx.sort_d(list)

      assert List.first(sorted_list) == Enum.min(list)
    end
  end
end

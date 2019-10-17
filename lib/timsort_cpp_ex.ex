defmodule TimsortCppEx do
  @moduledoc """
  Documentation for TimsortCppEx an Elixir NIF binding to the TimSort C++ library.
  """

  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif('./priv/timsort', 0)
  end

  @doc """
  Sort a list with TimSort
  Current NIF impl only accepts a list of integers.
  TimSort can handle a list of strings.
  TODO: implements other types, or defer the types to TimSort to handle

  ## Examples

      iex> TimsortCppEx.sort([9,7,2,3])
      [2,3,7,9]

  """
  @spec sort([]) :: []
  def sort([]), do: []

  @spec sort([integer()]) :: [integer()]
  def sort(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end
end

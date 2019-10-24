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
  Sorts a list of integers, a list of doubles, or a list of charlists.
  Other lists of Type.t() will return :error tuple

  ## Examples

      iex> TimsortCppEx.sort([9,7,2,3])
      [2,3,7,9]

      iex> TimsortCppEx.sort(['9','7','2','3'])
      ['2','3','7','9']
  """
  @spec sort([]) :: []
  def sort([]), do: []

  @spec sort([integer()]) :: [integer()]
  def sort([h | _] = list) when is_integer(h), do: sort_int(list)

  @spec sort([float()]) :: [float()]
  def sort([h | _] = list) when is_float(h), do: sort_float(list)

  @spec sort([String.t()]) :: [String.t()]
  def sort([h | _] = list) when is_bitstring(h) do
    {:error, "sort/(String.t()) not implemented for this type of list. Please convert strings to charlists"}
  end

  @spec sort([list()]) :: [list()] # A list of charlists
  def sort([h | _] = list) when is_list(h), do: sort_string(list)

  def sort(_) do
    {:error, "sort/1 not implemented for this type of list"}
  end

  @spec sort_int([integer()]) :: [integer()]
  defp sort_int(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end

  @spec sort_float([float()]) :: [float()]
  defp sort_float(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end

  @spec sort_string([String.t()]) :: [String.t()]
  defp sort_string(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end

  @doc """
  Sort a list with TimSort
  Sorts a list of integers or a list of doubles.
  Other lists of Type.t() will return :error tuple
  Enable support for Beam Dirty Scheduler

  ## Examples

      iex> TimsortCppEx.sort_d([9,7,2,3])
      [2,3,7,9]

  """
  @spec sort_d([]) :: []
  def sort_d([]), do: []

  @spec sort_d([integer()]) :: [integer()]
  def sort_d([h | _] = list) when is_integer(h), do: sort_int_d(list)

  @spec sort_d([float()]) :: [float()]
  def sort_d([h | _] = list) when is_float(h), do: sort_float_d(list)

  def sort_d(_) do
    {:error, "sort/1 not implemented for this type of list"}
  end

  @spec sort_int([integer()]) :: [integer()]
  defp sort_int_d(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end

  @spec sort_float([float()]) :: [float()]
  defp sort_float_d(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end
end

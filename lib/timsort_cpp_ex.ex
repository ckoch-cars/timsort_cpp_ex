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
  Sorts a list of integers or a list of doubles.
  Other lists of Type.t() will return :error tuple

  TimSort can handle a list of strings.
  TODO: implements other types, or defer the types to TimSort to handle

  ## Examples

      iex> TimsortCppEx.sort([9,7,2,3])
      [2,3,7,9]

  """
  @spec sort([]) :: []
  def sort([]), do: []

  @spec sort([integer()]) :: [integer()]
  def sort([h | _] = list) when is_integer(h), do: sort_int(list)

  @spec sort([float()]) :: [float()]
  def sort([h | _] = list) when is_float(h), do: sort_float(list)

  def sort(_) do
    {:error, "sort/1 not implemented for this type of list"}
  end

  # @spec sort_int([integer()]) :: [integer()]
  def sort_int(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end

  # @spec sort_float([float()]) :: [float()]
  def sort_float(_list) do
    raise :erlang.nif_error("NIF library not loaded")
  end

  # def sort_float(list), do: sort(list)

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
  def sort_d([h | _] = list) when is_integer(h), do: sort_int(list)

  @spec sort_d([float()]) :: [float()]
  def sort_d([h | _] = list) when is_float(h), do: sort_float(list)

  def sort_d(_) do
    {:error, "sort/1 not implemented for this type of list"}
  end
end

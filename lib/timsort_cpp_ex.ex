defmodule TimsortCppEx do
  @moduledoc """
  Documentation for TimsortCppEx an Elixir NIF binding to the TimSort C++ library.
  """

  # @app :timsort_cpp_ex

  # loading the NIF
  # def init do
  #   path = :filename.join(:code.priv_dir(unquote(@app)), 'timsort')
  #   :ok = :erlang.load_nif(path, 0)
  # end

  @on_load :load_nifs

  def load_nifs do
    :erlang.load_nif('./priv/timsort', 0)
  end

  @doc """
  Sort with TimSort

  ## Examples

      iex> TimsortCppEx.sort([9,7,2,3])
      [2,3,7,9]

  """
  def sort(_vector) do
    raise "NIF sort/1 not implemented"
  end
end

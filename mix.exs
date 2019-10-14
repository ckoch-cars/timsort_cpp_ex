defmodule TimsortCppEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :timsort_cpp_ex,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :porcelain]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:porcelain, "~> 2.0"}]
  end
end

defmodule Mix.Tasks.Compile.TimSort do
  def run(_) do
    File.mkdir_p("priv")

    {result, _error_code} =
      System.cmd(["cmake", "-H.", "-Bsrc", "-DCMAKE_BUILD_TYPE=Release"], ["src"],
        stderr_to_stdout: true
      )

    IO.binwrite(result)
    System.cmd(["./src/make"], ["priv/timsort.so"], stderr_to_stdout: true)
    # {result, _error_code} = System.cmd("make", ["priv/expand.so"], stderr_to_stdout: true)
    IO.binwrite(result)

    :ok
  end
end

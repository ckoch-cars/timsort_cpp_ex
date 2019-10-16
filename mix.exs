defmodule Mix.Tasks.Compile.TimSort do
  def run(_) do
    File.mkdir_p("priv/cpp-TimSort")

    {result, _error_code} =
      System.cmd(
        "cmake",
        ["-H.", "-Ssrc/cpp-TimSort", "-Bpriv/cpp-TimSort", "-DCMAKE_BUILD_TYPE=Release"],
        stderr_to_stdout: true
      )

    IO.binwrite(result)

    {result, _errcode} =
      System.cmd(
        "g++",
        [
          "--std=c++11",
          "-O3",
          "-fpic",
          "-shared",
          "-opriv/timsort.so",
          "-I/Users/christiankoch/erlang/22.0/erts-10.4/include",
          "-dynamiclib",
          "-undefined",
          "dynamic_lookup",
          "src/timsort.cpp"
        ],
        stderr_to_stdout: true
      )

    IO.binwrite(result)

    :ok
  end
end

defmodule TimsortCppEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :timsort_cpp_ex,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      compilers: [:tim_sort] ++ Mix.compilers(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
      # extra_applications: [:logger, :porcelain]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
    # [{:porcelain, "~> 2.0"}]
  end
end

# g++ --std=c++11 -O3 -fpic -shared -opriv/timsort.so -I/Users/christiankoch/erlang/22.0/erts-10.4/include src/timsort.cpp

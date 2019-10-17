defmodule Mix.Tasks.Compile.TimSort do
  def run(_) do
    File.mkdir_p("priv/cpp-TimSort")

    # if File.exists?("src/cpp-TimSort/include/gfx/timsort.hpp") do
    #   IO.puts("timsort.hpp appears to exist. Skipping the CMake step")
    # else
    #   IO.puts("timsort.hpp appears not to exist. Running CMake")

    #   {result, _error_code} =
    #     System.cmd(
    #       "cmake",
    #       ["-H.", "-Ssrc/cpp-TimSort", "-Bpriv/cpp-TimSort", "-DCMAKE_BUILD_TYPE=Release"],
    #       stderr_to_stdout: true
    #     )

    #   IO.binwrite(result)
    # end

    {result, _errcode} =
      System.cmd(
        "echo",
        [
          "************^^^^^^^^^^^^^^^^************\nCompiling NIF with src/timsort.cpp\n************^^^^^^^^^^^^^^^^************"
        ],
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
          # Include ERTS so we can find erl_nif.h at compile time.
          "-I$HOME/erlang/22.0/erts-10.4/include",
          # Include the incatation `-dynamiclib -undefined dynamic_lookup` to the compiler,
          # otherwise the the compilation works, but with an error about not being able to
          # find the compiled erl_nif functions
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
      aliases: aliases(),
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
    [{:stream_data, "~> 0.4"}]
    # [{:porcelain, "~> 2.0"}]
  end

  defp aliases do
    [
      test: [
        "cmd echo '************^^^^^^^^^^^^^^^^************'",
        "cmd echo 'Run TimSort C++ tests: '",
        "cmd echo '************^^^^^^^^^^^^^^^^************'",
        "cmd cd src/cpp-TimSort/build && CTest && cd ../../..",
        "cmd echo '************^^^^^^^^^^^^^^^^************'",
        "cmd echo 'Run TimSortCppEx elixir tests: '",
        "cmd echo '************^^^^^^^^^^^^^^^^************'",
        "test"
      ]
    ]
  end
end

# g++ --std=c++11 -O3 -fpic -shared -opriv/timsort.so -I/Users/christiankoch/erlang/22.0/erts-10.4/include src/timsort.cpp

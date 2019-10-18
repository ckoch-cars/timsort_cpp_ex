defmodule Mix.Tasks.Compile.TimSort do
  def run(_) do
    File.mkdir_p("priv/cpp-TimSort")

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
          # This will be unique to your system.
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

    # g++ --std=c++11 -O3 -fpic -shared -opriv/timsort.so -I/Users/christiankoch/erlang/22.0/erts-10.4/include src/timsort.cpp

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
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:stream_data, "~> 0.4"}]
  end

  defp aliases do
    [
      test_c: [
        "cmd echo '*^*~_~*^*~_~*^*~_~*^*~_~*^*~_~*^*~_~*^*~_~*^'",
        "cmd echo ",
        "cmd echo 'Run TimSort C++ tests:'",
        "cmd echo ",
        "cmd echo '********************************************'",
        "cmd cd src/cpp-TimSort/build && CTest && cd ../../.."
      ],
      test_ex: [
        "cmd echo '*^*~_~*^*~_~*^*~_~*^*~_~*^*~_~*^*~_~*^*~_~*^'",
        "cmd echo ",
        "cmd echo 'Run TimSortCppEx elixir tests:'",
        "cmd echo ",
        "cmd echo '********************************************'",
        "test"
      ],
      test_all: ["test_c", "test_ex"]
    ]
  end
end

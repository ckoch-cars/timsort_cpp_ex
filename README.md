# TimsortCppEx

TimsortCppEx implements the C++ library TimSort, which is an implementation of the TimSort context-aware sorting algorithm.

  - See: [TimSort](http://en.wikipedia.org/wiki/Timsort)

  - See: [cpp-TimSort](https://github.com/timsort/cpp-TimSort)


## Requirements

TimsortCppEx requires cmake to compile.

See [Installing CMake](https://cmake.org/install/)

In order to use the TimSort library from Elixir, you will need to compile timsort.cpp to run on your machine. `mix.exs` has some steps to make a best-effort to handle this.

TimSort (C++) is built with CMake. The command to run and build the library should be: `cmake -H. -Ssrc/cpp-TimSort -DCMAKE_BUILD_TYPE=Release -Bpriv/cpp-TimSort`

When compiling src/timsort.cpp to work for your local environment, you may need to update the g++ args specified in Mix.Tasks.Compile.TimSort.run/1 (mix.exs)
The "-I" flag arg will need to reflect your local installation of Erlang
`"-I/Users/christiankoch/erlang/22.0/erts-10.4/include"`


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `timsort_cpp_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:timsort_cpp_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/timsort_cpp_ex](https://hexdocs.pm/timsort_cpp_ex).


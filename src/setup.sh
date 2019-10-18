#!/usr/bin/env bash
echo "CMake timsort C++ library"
mkdir -p priv/cpp-TimSort
cmake -H. -Ssrc/cpp-TimSort -Bpriv/cpp-TimSort -DCMAKE_BUILD_TYPE=Release
